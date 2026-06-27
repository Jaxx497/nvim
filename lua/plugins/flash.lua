return {
    "jaxx497/flash.nvim",
    branch = "fix-search-labels",
    event = "VeryLazy",

    opts = {
        search = {
            multi_window = false,
            forward = true,
            wrap = true,
            mode = "exact"
        },
        jump = {
            nohlsearch = true,
            autojump = true,
            register = false,
        },
        label = {
            min_pattern_length = 1,
            after = true,
            rainbow = {
                enabled = true,
                shade = 5,
            },
        },
        modes = {
            search = {
                enabled = true,
            }
        },
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
