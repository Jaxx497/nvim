return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                -- htmldjango = { "prettier" },
                css = { "prettier" },
                html = { "htmlbeautifier" },
                javascript = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                python = { "black" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>fm", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "[F]or[m]at file or range (visual)" })
    end,
}