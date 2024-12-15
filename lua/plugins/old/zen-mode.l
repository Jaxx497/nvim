return {
    "folke/zen-mode.nvim",
    -- event = "VeryLazy",
    opts = {
        window = {
            backdrop = 1,
            width = 70,
            height = 999,
            options = {
                number = false,
                relativenumber = false,
                scrolloff = 999,
                list = false,
            },

            plugins = {
                options = {
                    enabled = true,
                },
                gitsigns = { enabled = false },
            }
        },
    },
    vim.api.nvim_set_keymap("n", "<leader>z", ":ZenMode<CR>", { desc = "[Z]enmode", silent = true }),
}
