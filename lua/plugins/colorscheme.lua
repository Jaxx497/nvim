return {
    -- Place this in your init.lua or another lua config file that gets sourced
    { "tomasr/molokai", event = "VeryLazy" },
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
        "loctvl842/monokai-pro.nvim",
        config = function()
            require("monokai-pro").setup()
        end,
    },

    -- {
    --     "srcery-colors/srcery-vim",
    --     name = "srcery",
    -- },

    {
        "RRethy/nvim-base16",
        -- priority = 1000,
        config = function()
            require("base16-colorscheme").with_config({
                cmp = false,
                telescope = false,
            })
            -- vim.cmd.colorscheme("base16-colors")
            vim.api.nvim_set_hl(0, "NonText", { fg = "#404040" })
        end,
    },


    -- Fade inactive windows, load after colorscheme
    --
    -- {
    --     "miversen33/sunglasses.nvim",
    --     config = function()
    --         require("sunglasses").setup({
    --             filter_type = "SHADE",
    --             filter_percent = 0.65,
    --         })
    --     end,
    -- }

    -- {
    --     'levouh/tint.nvim',
    --     event = "VeryLazy",
    --     config = function()
    --         require("tint").setup({
    --             tint = -60,
    --             saturation = 0.4,
    --
    --             window_ignore_function = function(winid)
    --                 local bufid = vim.api.nvim_win_get_buf(winid)
    --                 local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
    --                 local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
    --
    --                 return buftype == "terminal"
    --             end
    --         })
    --     end
    -- }
}
