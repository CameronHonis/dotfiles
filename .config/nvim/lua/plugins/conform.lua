return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            luau = { 'stylua' },
            lua = { 'stylua' },
            python = { 'isort', 'black' },
        },
    },
    config = function(_, opts)
        require('conform').setup(opts)
    end,
}
