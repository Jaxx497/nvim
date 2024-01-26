return {

    { "tomasr/molokai",          event = "VeryLazy" },
    { "Yazeed1s/minimal.nvim",   event = "VeryLazy" },
    { "tanvirtin/monokai.nvim",  event = "VeryLazy" },
    { "sekke276/dark_flat.nvim", event = "VeryLazy" },

    -- {
    --     "srcery-colors/srcery-vim",
    --     name = "srcery",
    -- },

    {
        "RRethy/nvim-base16",
        priority = 1000,
        config = function()
            require("base16-colorscheme").with_config({
                cmp = false,
                telescope = false,
            })
            vim.cmd.colorscheme("base16-colors")
            vim.api.nvim_set_hl(0, "NonText", { fg = "#404040" })
        end,
    },
}
