return {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
        local debugpy_python = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
        if vim.fn.executable(debugpy_python) ~= 1 then
            vim.notify("nvim-dap-python: debugpy not found in Mason.", vim.log.levels.WARN)
            return
        end

        local dap_python = require('dap-python')
        dap_python.setup(debugpy_python)
        dap_python.test_runner = 'pytest'

        -- Automatically try to use uv/venv for the code being debugged
        local original_resolve_python = dap_python.resolve_python
        dap_python.resolve_python = function()
            local cwd = vim.fn.getcwd()
            -- Check uv first
            local handle = io.popen('uv run which python 2>/dev/null')
            if handle then
                local result = handle:read('*a'):gsub('%s+$', '')
                handle:close()
                if result ~= '' and vim.fn.executable(result) == 1 then
                    return result
                end
            end
            -- Check .venv
            if vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            end
            return original_resolve_python()
        end

        -- Add some python-specific keymaps
        vim.keymap.set('n', '<leader>dn', function() dap_python.test_method() end, { desc = 'debug test method' })
        vim.keymap.set('n', '<leader>df', function() dap_python.test_class() end, { desc = 'debug test class' })
    end,
}
