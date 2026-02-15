-- use imagecolorpicker.com to find default colors from screenshots!!!

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, '@markup.strong.markdown_inline',
            { fg = '#FFAAFF', bold = true })

        vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg',
            { bg = '#000000', force = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg',
            { bg = '#000000', force = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg',
            { bg = '#000000', force = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg',
            { bg = '#000000', force = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg',
            { bg = '#000000', force = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg',
            { bg = '#000000', force = true })

        vim.api.nvim_set_hl(0, '@markup.raw.markdown_inline',
            { bg = '#141836', force = true })


        -- Set diagnostic underline colors based on severity
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError',
            { underline = false, bg = '#dd0000' }) -- Red for errors
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn',
            { underline = false, bg = '#dd6600' }) -- Yellow for warnings
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo',
            { underline = false, bg = '#0066dd' }) -- Blue for info
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint',
            { underline = false, bg = '#00dd66' }) -- Green for hints

        vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { link = 'Comment' })
    end
})
