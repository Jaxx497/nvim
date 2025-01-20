return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local conform = require("conform")
        conform.setup({

            -- formatters = {
            --     command = "sqlfluff",
            --     args = {
            --         "--dialect",
            --         "sqlite"
            --     }
            -- },
            formatters_by_ft = {
                c = { "clangd" },
                cpp = { "clangd" },
                css = { "prettierd" },
                html = { "htmlbeautifier" },
                javascript = { "prettierd" },
                json = { "prettierd" },
                sql = { "sqlfmt" },
                lua = { "stylelua" },
                python = { "ruff_format" },
                yaml = { "prettierd" }
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
