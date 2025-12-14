return function()
    vim.fn.system('git restore ' .. vim.fn.expand('%:p'))
    vim.cmd('edit!')
end
