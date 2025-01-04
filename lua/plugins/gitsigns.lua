return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },

        on_attach = function(bufnr)
            vim.keymap.set(
                "n",
                "<leader>hp",
                require("gitsigns").preview_hunk,
                { buffer = bufnr, desc = "preview git hunk" }
            )

            -- don't override the built-in and fugitive keymaps
            local gs = package.loaded.gitsigns
            vim.keymap.set({ "n", "v" }, "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<ignore>"
            end, { expr = true, buffer = bufnr, desc = "jump to next hunk" })
            vim.keymap.set({ "n", "v" }, "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<ignore>"
            end, { expr = true, buffer = bufnr, desc = "jump to previous hunk" })
        end,
    },
}
