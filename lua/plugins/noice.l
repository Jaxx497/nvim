return {
    "folke/noice.nvim",
    -- dependencies = { "MunifTanjim/nui.nvim",
    --     -- "rcarriga/nvim-notify",
    -- },
    event = "VeryLazy",
    opts = {
        lsp = {
            progress = {
                enabled = false,
                format = "lsp_progress",
                format_done = "lsp_progress_done",
                -- throttle = 1000 / 30,
                -- view = "notify",
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
        },
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
        -- notify = {
        --     render = "notify",
        --     replace = true
        -- },
        mini = {
            win_options = {
                winblend = 0
            }
        },
    },
}