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
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },

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

            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },

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
