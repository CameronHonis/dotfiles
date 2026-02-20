local M = {}

M.WriteAtCursor = function(text, offset_r, offset_c)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local r = cursor_pos[1] - 1 + offset_r
    local c = cursor_pos[2] + offset_c
    vim.api.nvim_buf_set_text(0, r, c, r, c, { text })
end

M.MoveToBottom = function(filename, is_insert_mode)
    if is_insert_mode == nil then
        is_insert_mode = true
    end
    -- open file in the current buf
    vim.cmd('edit ' .. filename)

    -- move to bottom of file and enter insert mode
    local lines_cnt = vim.api.nvim_buf_line_count(0)
    vim.api.nvim_win_set_cursor(0, { lines_cnt, 0 })
    if is_insert_mode then
        vim.cmd('startinsert')
    end
end

M.CreateNote = function(opts)
    opts = opts or {}
    local is_branch = false
    if opts.is_branch == nil then is_branch = true end

    local new_filename = os.date('!%Y%m%dT%H%M%SZ') .. '.md'
    local curr_filename = vim.fn.expand('%:t')
    local is_md = curr_filename:match('%.md$')
    is_branch = is_branch and is_md -- only branch from md files


    local heading = opts.args
    if heading == nil or heading == '' then
        heading = vim.fn.input('heading: ')
        if heading == '' then return end
    end

    -- ask for branch in prompt
    if is_branch then
        local branch_input = vim.fn.input('is branching? [y]/n: ')
        if branch_input == 'n' or branch_input == 'no' then
            is_branch = false
        end
    end

    local template = ""

    if is_branch then -- inject link in current note
        local tag_input = vim.fn.input('tag: ', heading)
        local tag = tag_input ~= '' and tag_input or heading
        local tag_md = ' [' .. tag .. '](' .. new_filename .. ')'
        M.WriteAtCursor(tag_md, 0, 1)

        template = template .. '[origin](' .. curr_filename .. ')\n\n'
    end

    template = template .. '# ' .. heading .. '\n\n'

    -- Create or open the file
    local file = io.open(new_filename, 'w')
    if file then
        file:write(template)
        file:close()
    end

    M.MoveToBottom(new_filename)
end

M.setup = function(opts)
    opts = opts or {}

    vim.api.nvim_create_user_command('Note', M.CreateNote, { nargs = '*' })
end

return M
