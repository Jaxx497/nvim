return {
    {
        priority = 1000,
        "tanvirtin/monokai.nvim",

        config = function()
            require("monokai").setup({
                {
                    palette = require("monokai").pro
                }
            })
        end,
    },

    {
        'levouh/tint.nvim',
        event = "VeryLazy",
        config = function()
            require("tint").setup({
                tint = -60,
                saturation = 0.4,

                window_ignore_function = function(winid)
                    local bufid = vim.api.nvim_win_get_buf(winid)
                    local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
                    local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

                    return buftype == floating
                end
            })
        end
    }
}
