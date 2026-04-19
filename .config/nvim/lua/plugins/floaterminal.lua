return {
    dir = vim.fn.stdpath('config') .. '/lua/floaterminal',
    enabled=false,
    keys = {
        { '<C-A-Y>', mode = { 'n', 't', 'i' }, '<cmd>FloaterminalToggle<CR>', desc = 'toggle floaterminal window' },
    },
    config = function()
        require('floaterminal').setup()
    end
}
