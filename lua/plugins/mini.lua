return {
    "nvim-mini/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
        require("mini.icons").setup()
        require("mini.operators").setup()
        require("mini.pairs").setup()
        require("mini.move").setup({
            mappings = {
                down = 'J',
                up = 'K',

                right = '>',
                left = '<',
                line_left = '<',
                line_right = '>',
            }
        })
        require("mini.trailspace").setup()
        require("mini.surround").setup({
            highlight_duration = 800,
            n_lines = 2,
            search_method = 'cover_or_next'
        })
    end,
}
