return {
    "folke/zen-mode.nvim",
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
        },
    },
    vim.api.nvim_set_keymap("n", "<leader>z", ":ZenMode<CR>", { desc = "[Z]enmode" }),
}
