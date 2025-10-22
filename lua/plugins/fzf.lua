return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",

    config = function()
        local fzf_lua = require('fzf-lua')

        fzf_lua.register_ui_select()
        fzf_lua.setup({
            winopts = {
                height     = 0.75,
                width      = 0.70,
                row        = 0.35,
                col        = 0.50,
                border     = "rounded",
                treesitter = {
                    enabled = true
                },
                preview    = {
                    title      = false,
                    vertical   = 'up:55%',
                    horizontal = 'right:70%',
                    layout     = "flex"
                }
            },

            files = {
                file_icons = "mini",
                git_icons = false,
                cwd_prompt = false, -- Hides the cwd in prompt
                header = false,     -- Hides `ctrl-g to toggle ...`
                formatter = "path.filename_first",
            },

            diagnostics = {
                previewer = false,
                multiline = false,
                winopts = {
                    width  = 0.75,
                    height = 0.4,
                    row    = 0.5,
                    col    = 0.5,
                }
            },

            keymap = {
                builtin = {
                    ["kj"] = "hide",
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
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
                ["--ansi"]           = true,
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

        vim.keymap.set("n", "<leader>f", fzf_lua.files, { desc = "Search Files" })
        vim.keymap.set("n", "<C-t>", fzf_lua.files, { desc = "Search Files" })
        vim.keymap.set("n", "<leader>re", fzf_lua.resume, { desc = "Search [Re]sume" })
        vim.keymap.set("n", "<leader>sg", fzf_lua.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>gw", fzf_lua.grep_cword, { desc = "[G]rep by [W]ord" })
        vim.keymap.set("n", "<leader>cs", fzf_lua.colorschemes, { desc = "Cycle colorschemes" })
        vim.keymap.set("n", "<leader>pb", fzf_lua.buffers, { desc = "[P]revious [B]uffers" })
        vim.keymap.set("n", "<leader>?", fzf_lua.oldfiles, { desc = "Old files" })
        vim.keymap.set("n", "<leader>gs", fzf_lua.git_status, { desc = "[G]it [S]tatus" })
        vim.keymap.set("n", "<leader>he", fzf_lua.help_tags, { desc = "[He]lp Tags" })
        vim.keymap.set("n", "<leader>gr", function() fzf_lua.lsp_references({ ignore_current_line = true }) end,
            { desc = "[G]o To [R]eferences" })
        vim.keymap.set("n", "<leader>d", fzf_lua.diagnostics_document, { desc = "Search [D]iagnostics" })
        vim.keymap.set("n", "<leader>D", fzf_lua.diagnostics_document, { desc = "Search all [D]" })
        vim.keymap.set("n", "qf", fzf_lua.quickfix, { desc = "[Q]uick[f]ix" })
        vim.keymap.set("n", "<leader>dw", fzf_lua.diagnostics_workspace,

            { desc = "[D]iagnostics [W]orkspace" })
        -- vim.keymap.set("n", "<leader>of",
        --     function()
        --         fzf_lua.lsp_document_symbols({
        --             regex_filter = function(item, _)
        --                 if item.kind:match('Function')
        --                     or item.kind:match('Method')
        --                     or item.kind:match('Object')
        --                     or item.kind:match('Struct') then
        --                     return true
        --                 else
        --                     return false
        --                 end
        --             end,
        --         })
        --     end
        -- )
    end,
}
