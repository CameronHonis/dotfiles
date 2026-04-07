local builtin = require "telescope.builtin"

return {
    'nvim-telescope/telescope.nvim',
    version = 'v2.*',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        { '<C-P>', mode = { 'n', 'x', 'o', 'i' }, '<cmd>Telescope find_files<CR>',                             desc = 'open file search by name' },
        { 'rg',    mode = { 'n', 'x', 'o' }, '<cmd>Telescope live_grep<CR>',                              desc = 'open project rip grep' },
        { 'gs',    mode = { 'n', 'x', 'o' }, '<cmd>Telescope lsp_document_symbols<CR>',                   desc = 'open document symbol search' },
        { 'c',    mode = { 'n', 'x', 'o' }, '<cmd>Telescope git_commits<CR>',                            desc = 'open git commits explorer' },
        { 'o',    mode = { 'n', 'x', 'o' }, '<cmd>GitBlameOpenCommitURL<CR>',                            desc = 'open git blame commit in browser' },
        { '<C-f>', mode = { 'n', 'x', 'o' }, ':Telescope file_browser path=%:p:h select_buffer=true<CR>', desc = 'open file browser' },
        { 'gr',    mode = { 'n', 'x', 'o' }, builtin.lsp_references,                 desc = 'Go to reference(s)' },
        { 'gi',    mode = { 'n', 'x', 'o' }, builtin.lsp_implementations,            desc = 'Go to implementation(s)' },
        { 'gt',    mode = { 'n', 'x', 'o' }, builtin.lsp_type_definitions,           desc = 'Go to type definition(s)' },
        { 'gd',    mode = { 'n', 'x', 'o' }, builtin.lsp_definitions,                                      desc = 'Go to definition' },
    },
    config = function()
        local fb_actions = require 'telescope'.extensions.file_browser.actions
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        local function preview_scroll(lines)
            return function(prompt_bufnr)
                local picker = action_state.get_current_picker(prompt_bufnr)
                local previewer = picker and picker.previewer
                if previewer and previewer.scroll_fn then
                    previewer:scroll_fn(lines)
                end
            end
        end

        require('telescope').setup {
            defaults = {
                initial_mode = "insert",
                mappings = {
                    i = {
                        ["<S-J>"] = preview_scroll(2),
                        ["<S-K>"] = preview_scroll(-2),
                    },
                    n = {
                        ["<S-J>"] = preview_scroll(2),
                        ["<S-K>"] = preview_scroll(-2),
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = {
                        "rg",
                        "--files",
                        "--glob",
                        "!.git/*",
                        "--path-separator",
                        "/",
                    },

                },
                live_grep = {
                    hidden = true,
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown()
                },
                file_browser = {
                    hidden = true,
                    mappings = {
                        --['n'] = {
                            --['H'] = fb_actions.goto_parent_dir,
                            --['<bs>'] = function() end,
                        --},
                        --['i'] = {
                            --['<bs>'] = function() print("asdf") end,
                        --}
                    }
                }
            }
        }

        require('telescope').load_extension 'ui-select'
        require('telescope').load_extension 'file_browser'
    end
}
