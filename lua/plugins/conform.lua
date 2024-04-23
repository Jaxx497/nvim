return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                c = { "clangd" },
                css = { "prettier" },
                html = { "htmlbeautifier" },
                javascript = { "prettier" },
                json = { "prettier" },
                lua = { "stylelua" },
                python = { "black" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 800,
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
