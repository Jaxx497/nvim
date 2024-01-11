return {

    { "kajamite/vim-monokai2",       event = "VeryLazy" },
    { "olimorris/onedarkpro.nvim",   event = "VeryLazy" },
    { "projekt0n/github-nvim-theme", event = "VeryLazy" },
    { "sekke276/dark_flat.nvim",     event = "VeryLazy" },
    { "tanvirtin/monokai.nvim",      event = "VeryLazy" },
    { "tomasr/molokai",              event = "VeryLazy" },
    { "Yazeed1s/minimal.nvim",       event = "VeryLazy" },

    { 'echasnovski/mini.base16',     version = '*' },
    {
        "srcery-colors/srcery-vim",
        name = "srcery",
    },

    {
        "RRethy/nvim-base16",
        priority = 1000,
        config = function()
            require("base16-colorscheme").with_config({
                cmp = false,
                telescope = false,
            })
            vim.cmd.colorscheme("base16-colors")
        end,
    },
}
