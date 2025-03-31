return {
    'saghen/blink.cmp',
    event = "VeryLazy",
    dependencies = {
        'echasnovski/mini.icons',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
        'xzbdmw/colorful-menu.nvim'
    },

    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'enter',
            ['<C-j>'] = { 'select_next' },
            ['<C-k>'] = { 'select_prev' },
        },

        appearance = {
            nerd_font_variant = 'mono',
            kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = '  ',
            }
        },

        completion = {
            menu = {
                draw = {
                    columns = {
                        { 'source_name' },
                        { 'label',      'label_description', gap = 1 },
                        { 'kind_icon' },
                        { 'kind' },
                    },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },

                        -- kind_icon = {
                        --     text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                        --     highlight = function(ctx) return ctx.kind_hl end,
                        -- },
                        kind = {
                            highlight = function(ctx)
                                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                    },
                    treesitter = { 'lsp' }
                },
                max_height = 12,
                min_width = 25,
                border = 'none'
            },
            documentation = {
                auto_show = true,
            },
            ghost_text = {
                enabled = true
            }
        },

        sources = {
            default = {
                'snippets',
                'lsp',
                'path',
                'buffer'
            },
            per_filetype = { sql = { 'dadbod' } },
            providers = {
                lsp = { name = "󰘧" },
                snippets = { name = "⋗" },
                buffer = { name = "󰏉" },
                path = { name = "" },
                dadbod = {
                    name = "",
                    module = "vim_dadbod_completion.blink",
                },
            }
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
