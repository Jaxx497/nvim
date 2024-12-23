return {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
        require('mini.icons').setup()
        -- MiniIcons.mock_nvim_web_devicons()
        require("fzf-lua").register_ui_select()
        require("fzf-lua").setup({

            winopts = {
                height     = 0.85,
                width      = 0.80,
                row        = 0.35,
                col        = 0.50,
                border     = "rounded",
                treesitter = {
                    enabled = true
                },
                preview    = {
                    vertical   = 'down:30%',
                    horizontal = 'right:70%',
                }

            },

            files = {
                git_icons = false,
                cwd_prompt = false,
            },

            diagnostics = {
                multiline = false,
                previewer = false
            },

            keymap = {
                builtin = {
                    ["kj"] = "hide",
                    ["<C-n>"] = "preview-page-down",
                    ["<C-p>"] = "preview-page-up"
                }
            },

            lsp = {
                code_actions = {
                    winopts = {
                        width  = 0.4,
                        height = 0.4,
                        row    = 0.5,
                        col    = 0.5,
                    },
                    previewer = false
                }
            },
            fzf_opts = {
                -- ["--ansi"]           = true,
                ["--info"]           = "inline-right", -- fzf < v0.42 = "inline"
                ["--pointer"]        = "",
                ["--height"]         = "100%",
                ["--layout"]         = "reverse-list",
                ["--border"]         = "none",
                ["--padding"]        = "5%",
                ["--highlight-line"] = false, -- fzf >= v0.53
            },

            fzf_colors = {
                ["bg+"] = "-1",
                ["gutter"] = "-1",
            }


        })

        vim.keymap.set("n", "<leader>f", require('fzf-lua').files, { desc = "Search Files" })
        vim.keymap.set("n", "<leader>ff", require('fzf-lua').resume, { desc = "Search Resume" })
        vim.keymap.set("n", "<leader>sg", require('fzf-lua').live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>gw", require('fzf-lua').grep_cword, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>cs", require('fzf-lua').colorschemes, { desc = "Cycle colorschemes" })
        vim.keymap.set("n", "<leader>fb", require('fzf-lua').buffers, { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>?", require('fzf-lua').oldfiles, { desc = "Old files" })
        vim.keymap.set("n", "<leader>gs", require('fzf-lua').git_status, { desc = "[G]it [S]tatus" })
        vim.keymap.set("n", "<leader>fh", require('fzf-lua').help_tags, { desc = "[F]ind [H]elp" })
        vim.keymap.set("n", "<leader>gr", require('fzf-lua').lsp_references, { desc = "[G]o To [R]eferences" })
        vim.keymap.set("n", "<leader>d", require('fzf-lua').diagnostics_document, { desc = "Search [D]iagnostics" })
        vim.keymap.set("n", "<leader>dw", require('fzf-lua').diagnostics_workspace,
            { desc = "[D]iagnostics [W]orkspace" })
    end,
}
