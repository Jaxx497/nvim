return {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = false,
    config = function()
        local animate = require('mini.animate')

        require("mini.pairs").setup()
        require("mini.icons").setup()
        require("mini.animate").setup({
            cursor = {
                enable = false
            },
            scroll = {
                enable = true,
                timing = animate.gen_timing.linear({ duration = 100, unit = 'total' })
            }
        })
        require('mini.surround').setup({
            highlight_duration = 800,
            n_lines = 2,
            search_method = 'cover_or_next'
        })
    end,
}
