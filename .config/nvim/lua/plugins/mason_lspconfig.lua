local LUALS_CONFIG = {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- Stop the server from asking to configure your workspace
                checkThirdParty = false,
            },
        },
    },
}

local PYRIGHT_CONFIG = {
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportUnusedExpression = "none",
                },
            },
        },
    },
}

return {
    'williamboman/mason-lspconfig.nvim',
    version = 'v1.*',
    dependencies = {
        'williamboman/mason.nvim',
    },
    config = function()
        require('mason-lspconfig').setup({
            handlers = {
                function(server_name)
                    local config = {
                        root_dir = vim.fn.getcwd(),
                    }
                    if server_name == 'lua_ls' then
                        config = vim.tbl_extend('force', config, LUALS_CONFIG)
                    elseif server_name == 'pyright' then
                        config = vim.tbl_extend('force', config, PYRIGHT_CONFIG)
                    end

                    require('lspconfig')[server_name].setup(config)
                end,
            },
        })

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
