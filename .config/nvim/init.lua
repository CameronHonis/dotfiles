local diagnostics = require('utils.diagnostics')

require('utils.dotenv').load_dotenv({ file_path = vim.fn.stdpath('config') .. '/.env' })

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
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
vim.api.nvim_set_hl(0, 'TSMarkupStrong', { bold = true, underline = true, fg = '#FF5733' })

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,     -- Sort diagnostics by severity (errors first)
    float = {
        severity_sort = true, -- Sort errors first in floating windows too
    },
    signs = true,
})

-- Set diagnostic underline colors based on severity
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { underline = false, bg = '#dd0000' }) -- Red for errors
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { underline = false, bg = '#dd6600' })  -- Yellow for warnings
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { underline = false, bg = '#0066dd' })  -- Blue for info
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { underline = false, bg = '#00dd66' })  -- Green for hints


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

-- TODO:
-- togglable indent strategy
-- color terminal background when in terminal mode
-- ripgrep search in regex & literal mode
-- picker for mini.diff source origin (default git index)
-- create snippets
-- create debug/run configs
-- commenting in .md files instead toggles cross-out decoration
-- FIX: `gr` (at least in .md files) stalls for a second
-- live update of diff in status bar (from buffer not file)
-- disable auto-insert comment symbol on new line
-- utilize nvim line wrapping but modify nav controls to respect line wraps
-- file search and file browser should have "show hidden files" state
--
--
-- Plugins to try:
-- conform.nvim
-- oil.nvim
--
-- Note Taking tools:
-- 1. `Idea` & `Question`
--  requires: file (note) name
--  desc: Creates new note (with boilerplate already added) and adds a link back to the last note, if last buffer contents was a note
--
-- 2. `Concept`
--  requires: file (note) name
--  desc: Creates a new note (with boilerplate already added). does not create links.
--
-- 3. `Questions` & `UnansweredQuestions
--  desc: Opens questions within X connections of the current note.
--
