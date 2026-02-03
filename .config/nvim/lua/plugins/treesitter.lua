return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

        vim.api.nvim_create_autocmd('ColorScheme', {
            callback = function()
            end
        })

        require("nvim-treesitter.configs").setup({
            ensure_installed = {
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
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "rust",
                "sql",
                "toml",
                "tsv",
                "typescript",
                "xml",
                "yaml",
                "zig",
            },
            fold = {
                enable = true,
            },
            highlight = {
                enable = true,
            },
            -- Add other modules as needed, e.g., indent, matchup
            -- indent = { enable = true },
            -- matchup = { enable = true },
        })
    end,
}
