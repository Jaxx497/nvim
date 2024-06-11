return {

    { "tomasr/molokai",         event = "VeryLazy" },
    { "tanvirtin/monokai.nvim", event = "VeryLazy" },

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

    -- Fade inactive windows, load after colorscheme
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

                    return buftype == "terminal" or floating
                end
            })
        end
    }
}
