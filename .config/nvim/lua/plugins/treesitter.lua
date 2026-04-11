return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- Force treesitter folding for all buffers where treesitter is active
        vim.api.nvim_create_autocmd({ "FileType" }, {
            callback = function()
                -- You can list specific filetypes or just apply to all
                vim.opt_local.foldmethod = "expr"
                vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end,
        })

        -- enable improved folding capabilities
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.supports_method("textDocument/foldingRange") then
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
                end
            end,
        })

        -- try highlighting for all files
        vim.api.nvim_create_autocmd('FileType', {
            callback = function() pcall(vim.treesitter.start) end,
        })

        require 'nvim-treesitter'.setup {
            install_dir = vim.fn.stdpath('data') .. '/parsers'
        }

        require('nvim-treesitter').install({
            "bash",
            "c",
            "cpp",
            "csv",
            "cuda",
            "dockerfile",
            "go",
            "html",
            "java",
            "javascript",
            "json",
            "latex", --optional for render-markdown plugin
            "lua",
            "make",
            "markdown",        --required for render-markdown plugin
            "markdown_inline", --required for render-markdown plugin
            "python",
            "rust",
            "sql",
            "toml",
            "tsv",
            "typescript",
            "xml",
            "yaml",
            "zig",
        })
    end,
}
