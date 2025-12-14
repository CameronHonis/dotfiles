return function()
    if vim.opt.tabstop._value == 2 then
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        print("indent set to 4")
    else
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        print("indent set to 2")
    end
end
