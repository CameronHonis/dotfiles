local OPENROUTER_ADAPTERS = {
    ['[openrouter] gpt 4o mini'] = { tag = 'openai/gpt-4o-mini' },
    ['[openrouter] gpt 4.1 mini'] = { tag = 'openai/gpt-4.1-mini' },
    ['[openrouter] gemini 2.5 flash lite'] = { tag = 'google/gemini-2.5-flash-lite' },
    ['[openrouter] gemini 3 flash preview'] = { tag = 'google/gemini-3-flash-preview' },
}

local DEFAULT_ADAPTER = '[openrouter] gemini 3 flash preview'

return {
    'olimorris/codecompanion.nvim',
    version = 'v18.*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'j-hui/fidget.nvim',
    },
    config = function()
        local make_openrouter_adapter = function(model_tag)
            return function()
                local openrouter_key = os.getenv('OPENROUTER_API_KEY')
                return require('codecompanion.adapters').extend('openai_compatible', {
                    env = {
                        url = 'https://openrouter.ai/api',
                        api_key = openrouter_key,
                        chat_url = '/v1/chat/completions',
                    },
                    schema = {
                        model = {
                            default = model_tag,
                        },
                    },
                })
            end
        end

        local or_adapters = {}
        for key, value in pairs(OPENROUTER_ADAPTERS) do
            or_adapters[key] = make_openrouter_adapter(value.tag)
        end

        require('codecompanion').setup({
            display = {
                action_palette = {
                    opts = {
                        show_default_actions = true,
                        show_default_prompt_library = true,
                    }
                }
            },
            adapters = {
                http = or_adapters,
            },
            strategies = {
                chat = {
                    adapter = DEFAULT_ADAPTER,
                    slash_commands = {
                    },
                    tools = {
                    },
                },
                inline = {
                    adapter = DEFAULT_ADAPTER,
                },
            },
            chat = {
                window = {
                    layout = 'float',
                    border = 'single',
                },
            },
        })

        vim.keymap.set({ 'n', 'i' }, '<M-C-;>', require('codecompanion').toggle,
            { desc = 'Toggle CodeCompanion chat window' })
    end,
    init = function()
        require('plugins.lualine.codecompanion_fidget'):init()
    end
}
