return {
    { -- Lsp Info
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                }
            }
        },
    },

    {
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        opts = {
            time_interval = 7
        },
    },

    { -- Show hex values in terminal
        'brenoprata10/nvim-highlight-colors',
        event = "VeryLazy",
        opts = {}
    },

    { -- Transparency
        "xiyaowong/transparent.nvim",
        config = function()
            require("transparent").setup({
                extra_groups = {
                    "Folded",
                    "GitGutterAdd",
                    "GitGutterChange",
                    "GitGutterChangeDelete",
                    "GitGutterDelete",
                    "Normal",
                    "NormalFloat",
                    "FloatBorder",
                    "RenderMarkdownCode",
                    "RenderMarkdownCodeInline",
                    "Special",
                    "BlinkCmpMenu",
                    "BlinkCmpMenuBorder",
                    "BlinkCmpKind",
                    "BlinkCmpSource"
                }
            })
        end,
        vim.keymap.set("n", "<F4>", ":TransparentToggle<CR>", { silent = true })
    },

    {
        "folke/todo-comments.nvim",
        event = "LspAttach",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    { -- Outline
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = { { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" } },
        opts = {
            outline_window = {
                width = 40,
                relative_width = false,

                auto_close = true,
                auto_jump = true,
                keymaps = {
                    goto_and_close = "<Cr>",
                },
            },
        },
    },

    { -- View, toggle and display marks
        "kshenoy/vim-signature",
        event = "VeryLazy"

    },
}
