local function format()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local has_formatter = false
    for _, client in pairs(clients) do
        if client.supports_method and client:supports_method("textDocument/formatting") then
            has_formatter = true
            break
        end
    end

    if has_formatter then
        vim.lsp.buf.format()
        print("formatted via LSP")
    else
        local view = vim.fn.winsaveview()
        local buf = vim.api.nvim_get_current_buf()
        local original_text = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local tmpname = os.tmpname()

        -- Save current buffer to a temp file
        vim.fn.writefile(original_text, tmpname)

        -- Run formatter on temp file
        vim.fn.system('black ' .. tmpname)

        -- Read formatted lines back
        local formatted = vim.fn.readfile(tmpname)

        -- Replace buffer content if formatter succeeded
        if vim.v.shell_error == 0 then
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, formatted)
        end

        -- Restore view (cursor position, folds, etc)
        vim.fn.winrestview(view)

        -- Remove temp file
        os.remove(tmpname)
        print("formatted via python black")
    end
end

return {
    'neovim/nvim-lspconfig',
    version = 'v1.*',
    config = function()
        vim.keymap.set({ 'n', 'i' }, '<F5>', '<cmd>LspRestart<CR>', { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'i' }, '<C-A-P>', vim.lsp.buf.signature_help, { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'i' }, '<C-A-R>', vim.lsp.buf.rename, { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'i' }, '<M-CR>', vim.lsp.buf.code_action, { noremap = true, silent = true })

        vim.keymap.set({ 'n', 'i' }, '<M-C-,>', format, { noremap = true, silent = true })
    end
}
