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

    -- { -- Additional keybindings
    --     'tummetott/unimpaired.nvim',
    --     event = "VeryLazy",
    --     config = function()
    --         require('unimpaired').setup {}
    --     end
    -- },

    { -- Search and replace
        "nvim-pack/nvim-spectre",
        event = "VeryLazy"
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
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    { -- Outline
        "hedyhli/outline.nvim",
        lazy = true,
        event = "VeryLazy",
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
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

    { "kshenoy/vim-signature", event = "VeryLazy" }, -- View, toggle and display marks

    {
        "folke/trouble.nvim",
        opts = {
            auto_close = true,
            focus = true,
            preview = {
                border = "none",
                scratch = false
            },
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>qf",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xj",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>oo",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    }

    -- Git related
    -- { "tpope/vim-rhubarb",  event = "VeryLazy" },
}
