return {
    { "xiyaowong/transparent.nvim" },
    { "kshenoy/vim-signature",     event = "VeryLazy" },
    { "stevearc/dressing.nvim",    event = "VeryLazy", },
    { "tpope/vim-fugitive",        event = "VeryLazy" },
    { "tpope/vim-rhubarb",         event = "VeryLazy" },
    { "tpope/vim-sleuth",          event = "VeryLazy" },
    { "j-hui/fidget.nvim",         event = "LspAttach", opts = {} },
    {
        'tummetott/unimpaired.nvim',
        event = "VeryLazy",
        config = function()
            require('unimpaired').setup {}
        end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },
    {
        'Bekaboo/dropbar.nvim',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim'
        },
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
    }
}
