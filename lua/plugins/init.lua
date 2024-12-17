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
                    "TelescopeNormal",
                    "TelescopePromptBorder",
                    "FoldColumn"
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

    { "tpope/vim-fugitive",     event = "VeryLazy" },
    { "tpope/vim-rhubarb",      event = "VeryLazy" },
    { "stevearc/dressing.nvim", event = "VeryLazy", }, -- Prettier view of things
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
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },

        { 'Bilal2453/luvit-meta', lazy = true },
    },

    -- {
    --     'Bekaboo/dropbar.nvim',
    --     dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' },
    --
    --     opts = {
    --         menu = {
    --             win_configs = {
    --                 border = "rounded"
    --             }
    --         }
    --     },
    --     vim.keymap.set("n", "<leader>db", ":lua require('dropbar.api').pick()<CR>")
    -- },
}
