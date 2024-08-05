return {
    {
        "xiyaowong/transparent.nvim",
        config = function()
            require("transparent").setup({
                extra_groups = { "GitGutterAdd",
                    "GitGutterChange",
                    "GitGutterChangeDelete",
                    "GitGutterDelete" }
            })
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {}
    },
    { "kshenoy/vim-signature",  event = "VeryLazy" },
    { "stevearc/dressing.nvim", event = "VeryLazy", },
    { "tpope/vim-fugitive",     event = "VeryLazy" },
    { "tpope/vim-rhubarb",      event = "VeryLazy" },
    { "tpope/vim-sleuth",       event = "VeryLazy" },

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
        'Bekaboo/dropbar.nvim',
        dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' },

        opts = {
            menu = {
                win_configs = {
                    border = "rounded"
                }
            }
        },
        vim.keymap.set("n", "<leader>db", ":lua require('dropbar.api').pick()<CR>")
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
    },

    { "Bilal2453/luvit-meta", lazy = true },

    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
}
