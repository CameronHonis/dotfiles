return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'

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
