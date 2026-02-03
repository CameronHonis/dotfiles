require('colors')
local diagnostics = require('utils.diagnostics')
require('utils.dotenv').load_dotenv({ file_path = vim.fn.stdpath('config') .. '/.env' })

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

--- @type {fs_stat: fun(path: string): [number, nil] | [nil, string]} uv
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    defaults = {
        lazy = false,
    }
})

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.paste = false
vim.opt.ignorecase = true
vim.opt.swapfile = true
vim.opt.directory = '.'
vim.opt.laststatus = 3
vim.opt.signcolumn = 'auto:2'

vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldenable = false  -- Optional: start with folds closed
vim.opt.foldlevelstart = 99 -- Optional: start with folds open

vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false


vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

vim.cmd [[ highlight ColorColumn guibg=#151820 ]]
vim.opt.colorcolumn = "80" -- Set the desired color column position

-- move me to syntax_colors.lua
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,     -- Sort diagnostics by severity (errors first)
    float = {
        severity_sort = true, -- Sort errors first in floating windows too
    },
    signs = true,
})

-- nops
vim.api.nvim_set_keymap('n', '<C-S-O>', '<Nop>', { noremap = true, silent = true })

-- forward/back nav
vim.api.nvim_set_keymap('n', 'H', '<C-o>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', '<C-i>', { noremap = true, silent = true })

-- more fine grained undo/redo
vim.keymap.set("i", "<space>", "<space><c-g>u", { noremap = true })
vim.keymap.set("i", ".", ".<c-g>u", { noremap = true })
vim.keymap.set("i", ",", ",<c-g>u", { noremap = true })
vim.keymap.set("i", ";", ";<c-g>u", { noremap = true })
vim.keymap.set("i", "<CR>", "<CR><c-g>u", { noremap = true })

-- jump to diagnostics
vim.keymap.set('n', '<C-j>', diagnostics.jump_to_next_diagnostic, { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', diagnostics.jump_to_prev_diagnostic, { noremap = true, silent = true })

-- switch to editing this config file
vim.keymap.set('n', '<C-A-A>', function()
    local path = vim.fn.expand('$MYVIMRC')
    vim.cmd('edit ' .. path)
    vim.cmd('lcd ' .. vim.fn.fnamemodify(path, ':h'))
end, { noremap = true, silent = true })

vim.api.nvim_create_user_command('Rename', require('utils.rename_file'), { nargs = '?', complete = 'file' })
vim.api.nvim_create_user_command('GitRestore', require('utils.git_restore'),
    { desc = 'restore current file to git HEAD' })

-- terminal navigation toggle
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- set help buffers to be resizable using hotkeys
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.cmd('wincmd L')
        vim.opt_local.winfixwidth = false
    end,
})

vim.api.nvim_create_user_command('IndentToggle', require('utils.indent_toggle'), {})
