local dap = require("dap")

local function set_cond_breakpoint()
    local cond = vim.fn.input("Breakpoint condition: ")
    dap.set_breakpoint(cond)
end

local function dapui_eval_expr()
    require('dapui').eval()
end

return {
    'mfussenegger/nvim-dap',
    version = 'v0.*',
    dependencies = { 'williamboman/mason.nvim', 'rcarriga/nvim-dap-ui' },
    keys = {
        { '<M-C-b>',   mode = { 'n', 'i' }, dap.toggle_breakpoint, desc = 'toggle breakpoint for line' },
        { '<M-C-S-B>', mode = { 'n' },      set_cond_breakpoint,   desc = 'conditional breakpoint' },
        { '<M-C-c>',   mode = { 'n', 'i' }, dap.continue,          desc = 'start/manage debug runtime' },
        { '<M-C-j>',   mode = { 'n', 'i' }, dap.step_into,         desc = 'step into [debug]' },
        { '<M-C-l>',   mode = { 'n', 'i' }, dap.step_over,         desc = 'step over [debug]' },
        { '<M-C-k>',   mode = { 'n', 'i' }, dap.step_out,          desc = 'step out [debug]' },
        { '<M-C-h>',   mode = { 'n', 'v' }, dapui_eval_expr,       desc = 'evaluate expression' },
        { '<M-C-r>',   mode = { 'n' },      dap.run_last,          desc = 'rerun last debug config' },
        {
            '<M-C-y>',
            mode = { 'n', 'i' },
            function()
                if require('dap').session() then
                    require('dap').repl.toggle()
                else
                    vim.notify("No active debug session", vim.log.levels.INFO)
                end
            end,
            desc = 'toggle dap repl'
        },
    },
    config = function()
        local dap = require('dap')

        -- Note: Adapter and configuration for python is handled by nvim-dap-python
        vim.fn.sign_define('DapBreakpoint',
            { text = '●', texthl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointCondition',
            { text = '⊙', texthl = 'DapBreakpointCondition' })
        vim.fn.sign_define('DapLogPoint',
            { text = '○', texthl = 'DapLogPoint' })

        -- Close the REPL when a debug session ends
        local function close_repl_if_open()
            -- The REPL buffer is named [dap-repl]; close any windows showing it
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local name = vim.api.nvim_buf_get_name(buf)
                if name:match('%[dap%-repl%]') then
                    vim.api.nvim_win_close(win, true)
                end
            end
        end

        dap.listeners.before.event_terminated.dap_repl_autoclose = close_repl_if_open
        dap.listeners.before.event_exited.dap_repl_autoclose     = close_repl_if_open
        dap.listeners.before.disconnect.dap_repl_autoclose       = close_repl_if_open

        vim.keymap.set('n', '<M-C-e>', function()
            local dap = require('dap')
            if vim.g.exception_breakpoints_enabled then
                dap.set_exception_breakpoints({})
                vim.g.exception_breakpoints_enabled = false
                vim.notify("Exception breakpoints disabled", vim.log.levels.INFO)
            else
                dap.set_exception_breakpoints({ 'raised', 'uncaught' })
                vim.g.exception_breakpoints_enabled = true
                vim.notify("Break on exceptions: raised, uncaught", vim.log.levels.INFO)
            end
        end, { desc = 'toggle exception breakpoints' })
    end,
}
