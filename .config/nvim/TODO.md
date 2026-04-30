# TODO
## Easy
- [ ] swap keybinds to `which-key.nvim`
- [ ] allow GitRevert to work in selection only
- [ ] fix 'Capture' util
- [ ] add remote syncing
- [ ] update keybinds for molten
- [ ] enable treesitter navigation for molten
- [ ] use `smajwill/nvim-unception` to allow using git in nvim
- [ ] shells spawned in nvim (via `:term`) should inherit state from parent shell
- [ ] remove floaterminal
- [ ] put cursor to right pane when `:vs`
- [ ] utilize nvim **line wrapping** but modify nav controls to respect line wraps
- [ ] **live** update of diff in status bar (from buffer not file)
- [ ] **disable auto-insert comment** symbol on new line
- [ ] commenting in .md files instead renders as strike-through (what?)

## Medium
- [ ] add treesitter nav jumps (including jupiter nb)
- [ ] file search and file browser should have "**show hidden files**" state
- [ ] ripgrep search in **regex & literal** mode
- [ ] color **terminal background** when in terminal mode
- [ ] picker for **mini.diff source** origin (default git index)
- [ ] create snippets

## Hard
- [ ] ONGOING: create **debug/run** configs

# experiment with
* plugins `swap-diff.nvim` vs `recover.nvim`
* `snacks.nvim`'s pickers instead of telescope
* plugin `conform.nvim`
* plugin `oil.nvim`
* https://github.com/Amansingh-afk/milli.nvim


# sort for later
* different blink cmp selector that works
* debug show dap repl instead of dogshit dapui console
* debug hide hypertext, dapui when no frame paused
* debug stop
* debug breakpoints picker/manager (also maybe persistent breakpoints)
* remove path to status line
* add copy file path + AST nodes (copy file path already exists, remove it)
* add AST specific nav controls
    * jump up a level
    * jump to next arg
    * select up a level
* figure out how to wrap selected text with function call
* resolve warning at startup
* replace beads with something that doesnt suck
* add snippets for markdown alerts
* set fold level based on cursor position
* remove input delay for `gr`
* get better jsx (maybe also tsx) LSP
