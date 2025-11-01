local previewers = require('telescope.previewers')
local imager = require('image')

local img = nil

local function image_preview_maker(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)

    if img ~= nil then
        img:clear()
        img = nil
    end

    local is_image = filepath:match("^.+(%..+)$") and
        vim.tbl_contains({ '.png', '.jpg', '.jpeg', '.gif', '.bmp' }, filepath:sub(-4):lower())
    local rendered = false
    if is_image then
        -- Save current window to restore later
        local current_win = vim.api.nvim_get_current_win()
        -- Switch to the window displaying the buffer for correct rendering context
        local win_for_buf = nil
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == bufnr then
                win_for_buf = win
                break
            end
        end
        if win_for_buf then
            vim.api.nvim_set_current_win(win_for_buf)
        end

        vim.api.nvim_buf_call(bufnr, function()
            img = imager.from_file(filepath)
            if img ~= nil then
                rendered = true
                img:render()
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
            end
        end)

        -- Restore original window
        vim.api.nvim_set_current_win(current_win)
    end
    if not rendered then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
end

return image_preview_maker
