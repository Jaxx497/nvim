return {
    {
        'tummetott/unimpaired.nvim',
        event = "VeryLazy",
        config = function()
            require('unimpaired').setup {}
        end
    },

    { "kshenoy/vim-signature", event = "VeryLazy" },
    { "tpope/vim-sleuth",      event = "VeryLazy" },

    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },


    -- "neovim/nvim-lspconfig",
    -- "williamboman/mason.nvim",
    -- "williamboman/mason-lspconfig.nvim",
    -- "hrsh7th/nvim-cmp",
    -- "hrsh7th/cmp-nvim-lsp",
    -- "hrsh7th/cmp-buffer",
    -- "hrsh7th/cmp-path",
    -- "saadparwaiz1/cmp_luasnip",
    -- "hrsh7th/cmp-nvim-lua",
    -- "L3MON4D3/LuaSnip",
    -- "rafamadriz/friendly-snippets",


    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {},
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },


    -----  GIT  -----

    { "tpope/vim-fugitive", event = "VeryLazy" },
    { "tpope/vim-rhubarb",  event = "VeryLazy" },


    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            -- see `:help gitsigns.txt`
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },

            numhl = true,

            on_attach = function(bufnr)
                vim.keymap.set(
                    "n",
                    "<leader>hp",
                    require("gitsigns").preview_hunk,
                    { buffer = bufnr, desc = "preview git hunk" }
                )

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ "n", "v" }, "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<ignore>"
                end, { expr = true, buffer = bufnr, desc = "jump to next hunk" })
                vim.keymap.set({ "n", "v" }, "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<ignore>"
                end, { expr = true, buffer = bufnr, desc = "jump to previous hunk" })
            end,
        },
    },

}
