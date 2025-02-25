return {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = false,
    config = function()
        require("mini.pairs").setup()
        require("mini.icons").setup()
        require("mini.surround").setup({
            highlight_duration = 800,
            n_lines = 2,
            search_method = 'cover_or_next'
        })
    end,
}
