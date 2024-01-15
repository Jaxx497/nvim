return {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        icon_preset = "diamond" },
                },
                ["core.esupports.indent"] = {
                    config = {
                        format_on_enter = "false",
                    }
                },
                ["core.export"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                    },
                },
            },
            keys = {
                vim.keymap.set(
                    "n",
                    "<leader>ne",
                    ":Neorg export to-file<CR>.md<Left><Left><Left>",
                    { desc = "[N]eorg [E]xport to file" }
                ),
            },
            init_open_folds = "always",
        })
    end,
}
