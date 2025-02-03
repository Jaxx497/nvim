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

    { -- Folding
        'kevinhwang91/nvim-ufo',
        event = "BufReadPre",
        dependencies = { 'kevinhwang91/promise-async' },
        opts = {},

    },

    { -- Additional keybindings
        'tummetott/unimpaired.nvim',
        event = "VeryLazy",
        config = function()
            require('unimpaired').setup {}
        end
    },

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
                    -- "@markup.raw.block.markdown"
                    "Special"
                    -- "FoldColumn"
                }
            })
        end,
        vim.keymap.set("n", "<F4>", ":TransparentToggle<CR>", { silent = true })
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

    -- {
    --     "rachartier/tiny-inline-diagnostic.nvim",
    --     event = "VeryLazy", -- Or `LspAttach`
    --     priority = 1000,    -- needs to be loaded in first
    --     config = function()
    --         require('tiny-inline-diagnostic').setup({
    --             preset = "powerline"
    --         })
    --     end
    -- }

    -- {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     build =
    --     "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    -- },


    -- Git related
    -- { "tpope/vim-fugitive", event = "VeryLazy" },
    -- { "tpope/vim-rhubarb",  event = "VeryLazy" },
}
