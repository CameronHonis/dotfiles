local LUALS_CONFIG = {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

return {
    'williamboman/mason-lspconfig.nvim',
    version = 'v1.*',
    dependencies = {
        'williamboman/mason.nvim',
        'b0o/schemastore.nvim',
    },
    config = function()
        local JSONLS = {
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        }

        local function find_definition_files(root)
            local files = {}
            local git_out = vim.fn.systemlist(
                { 'git', '-C', root, 'ls-files', '--cached', '--others', '--exclude-standard', '*.d.luau' }
            )
            if vim.v.shell_error == 0 then
                for _, rel in ipairs(git_out) do
                    if rel ~= '' then
                        table.insert(files, root .. '/' .. rel)
                    end
                end
                return files
            end
            return vim.fs.find(function(name)
                return name:match('%.d%.luau$')
            end, { path = root, type = 'file', limit = math.huge })
        end

        local function build_luau_cmd(root)
            local args = {
                vim.fn.exepath('luau-lsp'),
                'lsp',
                '--flag:LuauSolverV2=true',
            }
            for _, file in ipairs(find_definition_files(root)) do
                local rel_path = vim.fs.relpath(root, file)
                local module_name = vim.fs.basename(file):gsub('%.d%.luau$', '')
                table.insert(args, '--definitions=@' .. module_name .. '=' .. rel_path)
            end
            return args
        end

        require('mason-lspconfig').setup({
            handlers = {
                function(server_name)
                    local config = {
                        root_dir = vim.fs.root(0, { '.luaurc', 'default.project.json', '.git' }) or vim.fn.getcwd(),
                        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
                    }
                    if server_name == 'lua_ls' then
                        config = vim.tbl_extend('force', config, LUALS_CONFIG)
                    elseif server_name == 'jsonls' then
                        config = vim.tbl_extend('force', config, JSONLS)
                    elseif server_name == 'luau_lsp' then
                        config.cmd = build_luau_cmd(config.root_dir)
                    end

                    require('lspconfig')[server_name].setup(config)
                end,
            },
        })

        vim.api.nvim_create_user_command('LspRestartLuau', function()
            for _, client in ipairs(vim.lsp.get_clients()) do
                if client.name == 'luau_lsp' and client.config.root_dir then
                    client.config.cmd = build_luau_cmd(client.config.root_dir)
                end
            end
            vim.cmd('LspRestart')
        end, {})

        vim.api.nvim_create_user_command('LspList', function()
            local clients = vim.lsp.get_clients()
            if #clients == 0 then
                print('No active LSP clients.')
            else
                for i, client in ipairs(clients) do
                    print(string.format('%d. %s (id: %d)', i, client.name, client.id))
                end
            end
        end, {})
    end
}
