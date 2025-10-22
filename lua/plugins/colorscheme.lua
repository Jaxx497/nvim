return {
    {
        priority = 1000,
        "tanvirtin/monokai.nvim",

        config = function()
            require("monokai").setup({
                {
                    palette = require("monokai").pro,
                }
            })
        end,
    }
}
