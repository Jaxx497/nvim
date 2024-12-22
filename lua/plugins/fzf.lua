return {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
        require('mini.icons').setup()
        -- MiniIcons.mock_nvim_web_devicons()
        -- local actions = require "fzf-lua.actions"
        require("fzf-lua").setup({
            winopts = {
                height     = 0.85,
                width      = 0.80,
                row        = 0.35,
                col        = 0.50,
                treesitter = {
                    enabled = true
                },
            },

            keymap = {
                builtin = {
                    ["<C-n>"] = "preview-page-down",
                    ["<C-p>"] = "preview-page-up"
                }
            },
            files = {
                git_icons = false,
                cwd_prompt = false,
            }
        })

        vim.keymap.set("n", "<leader>f", require('fzf-lua').files, { desc = "Search Files" })
        vim.keymap.set("n", "<leader>cs", require('fzf-lua').colorschemes, { desc = "Cycle colorschemes" })
        vim.keymap.set("n", "<leader>sg", require('fzf-lua').live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>fb", require('fzf-lua').buffers, { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>?", require('fzf-lua').oldfiles, { desc = "Old files" })

        -- vim.keymap.set("n", "<leader>ff", require('fzf-lua').resume, { desc = "Search Resume" })
        -- vim.keymap.set("n", "<leader>fh", require('fzf-lua').help_tags, { desc = "[F]ind [H]elp" })
        -- vim.keymap.set("n", "<leader>fw", require('fzf-lua').grep_string, { desc = "[F]ind [W]ord" })
        -- vim.keymap.set("n", "<leader>gf", require('fzf-lua').git_commits, { desc = "[Git] commits" })
        -- vim.keymap.set("n", "<leader>gs", require('fzf-lua').git_status, { desc = "[G]it [S]tatus" })
        -- vim.keymap.set("n", "<leader>fg", require('fzf-lua').git_files, { desc = "[F]ind [G]it Files" })
        -- vim.keymap.set("n", "<leader>gr", require('fzf-lua').lsp_references, { desc = "[G]o To [R]eferences" })
        -- vim.keymap.set("n", "<leader>?", require('fzf-lua').oldfiles, { desc = "Find recently opened files" })
        -- vim.keymap.set("n", "<leader>sd", require('fzf-lua').diagnostics, { desc = "[S]earch [D]iagnostics" })
    end,

}
