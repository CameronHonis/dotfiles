local function format()
    require('conform').format({ bufnr = 0, lsp_fallback = true })
end

return {
    'neovim/nvim-lspconfig',
    version = 'v1.*',
    config = function()
        vim.keymap.set({ 'n', 'i' }, '<F5>', '<cmd>LspRestart<CR>', { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'i' }, '<C-A-P>', vim.lsp.buf.signature_help, { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'i' }, '<M-C-P>', vim.lsp.buf.signature_help, { noremap = true, silent = true }) --compatible with kitty
        vim.keymap.set({ 'n' }, '<C-H>', vim.lsp.buf.hover, { noremap = true, silent = true })
        vim.keymap.set({ 'n' }, '<leader>r', vim.lsp.buf.rename, { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'i' }, '<M-CR>', vim.lsp.buf.code_action, { noremap = true, silent = true })

        vim.keymap.set({ 'n', 'i' }, '<M-C-,>', format, { noremap = true, silent = true })
    end
}
