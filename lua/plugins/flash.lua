return {
    "folke/flash.nvim",
    event = "VeryLazy",
    --- @type Flash.Config
    opts = {
        modes = {
            search = {
                enabled = true
            }
        },
        jump = {
            nohlsearch = true,
            autojump = true,
        },
        label = {
            rainbow = {
                enabled = true,
                shade = 5,
            }
        }
    },

    keys = {
        {
            "<C-s>",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search",
        },
    },
}
