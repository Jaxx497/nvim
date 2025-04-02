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

    -- {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     build =
    --     "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    -- },


    -- Git related
    -- { "tpope/vim-fugitive", event = "VeryLazy" },
    -- { "tpope/vim-rhubarb",  event = "VeryLazy" },
}
