return {
    {
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
                    -- "FoldColumn"
                }
            })
        end,
        vim.keymap.set("n", "<F4>", ":TransparentToggle<CR>", { silent = true })
    },

    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {}
    },

    { "tpope/vim-fugitive", event = "VeryLazy" },
    { "tpope/vim-rhubarb",  event = "VeryLazy" },
    -- { "stevearc/dressing.nvim", event = "VeryLazy", }, -- Prettier view of things
    -- { "kshenoy/vim-signature", event = "VeryLazy" },     -- View, toggle and display marks
    -- { "tpope/vim-sleuth",      event = "VeryLazy" },     -- Adjust indentation

    {
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
        'tummetott/unimpaired.nvim',
        event = "VeryLazy",
        config = function()
            require('unimpaired').setup {}
        end
    },

    {
        "nvim-pack/nvim-spectre", event = "VeryLazy"
    }
}
