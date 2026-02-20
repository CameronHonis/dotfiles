return function(opts)
    local buf = vim.api.nvim_create_buf(false, true)
    local output = vim.api.nvim_cmd(opts.args, {output = true})
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, '\n'))
    vim.cmd.sbuffer(buf)
    vim.bo[buf].filetype = 'capture'
end
