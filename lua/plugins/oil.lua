return {
    "stevearc/oil.nvim",
    opts = {},
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    dependencies = { "echasnovski/mini.icons" },
    config = function()
        require("oil").setup({

            default_file_explorer = true,

            keymaps = {
                ["?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<BS>"] = "actions.parent",
                ["<C-s>"] = "actions.select_vsplit",
                -- ["<C-h>"] = "actions.select_split",
                ["S"] = "actions.select_split",
                ["<C-;>"] = "actions.refresh",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
            },

            use_default_keymaps = false,

            view_options = {
                show_hidden = false,
            },

            float = {
                max_width = 32,
                max_height = 25,
                border = "rounded",
                -- win_options = {
                -- 	winblend = 0,
                -- },
            },

            preview = {
                max_width = 0.4,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = 0.4,
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
        })

        vim.api.nvim_set_keymap(
            "n",
            "<leader>-",
            "<cmd>lua require('oil').toggle_float('.')<CR>",
            { noremap = true, silent = true, desc = "Open parent directory" }
        )
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
}
