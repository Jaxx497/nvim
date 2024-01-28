return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "folke/neodev.nvim",
        opts = {},
    },

    config = function()
        require("neodev").setup()
        local lspconfig = require("lspconfig")
        require('lspconfig.ui.windows').default_options.border = 'rounded'

        lspconfig.pyright.setup {}
        lspconfig.cssls.setup {}
        lspconfig.emmet_ls.setup {}
        lspconfig.html.setup {}
        lspconfig.lua_ls.setup {}

        local keymap = vim.keymap.set

        keymap("n", "<leader>e", vim.diagnostic.open_float)
        keymap('n', '[d', vim.diagnostic.goto_prev, { desc = "LSP: Go to previous diagnostic" })
        keymap('n', ']d', vim.diagnostic.goto_next, { desc = "LSP: Go to next diagnostic" })
        keymap('n', '<space>q', vim.diagnostic.setloclist)
        keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>",
            { desc = "LSP: Show buffer diagnostics" })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                keymap('n', 'gD', vim.lsp.buf.declaration, {
                    buffer = ev.buf,
                    desc = "LSP: [G]oto [D]eclaration"
                })
                keymap('n', 'gd', vim.lsp.buf.definition, {
                    buffer = ev.buf,
                    desc = "LSP: [G]oto [D]efinition"
                })
                keymap('n', 'K', vim.lsp.buf.hover, {
                    buffer = ev.buf,
                    desc = "LSP: Hover Documentation"
                })
                keymap('n', 'gi', vim.lsp.buf.implementation, {
                    buffer = ev.buf,
                    desc = "LSP: [G]oto [I]mplementation"
                })
                keymap('n', '<leader>k', vim.lsp.buf.signature_help,
                    {
                        buffer = ev.buf,
                        desc = "LSP: Signature Documentation"
                    })
                keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                    {
                        buffer = ev.buf,
                        desc = "LSP: [W]orkspace [A]dd Folder"
                    })
                keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                    {
                        buffer = ev.buf,
                        desc = "LSP: [W]orkspace [R]emove Folder"
                    })
                keymap('n', '<leader>rn', vim.lsp.buf.rename, {
                    buffer = ev.buf,
                    desc = "LSP: [R]e[n]ame"
                })
                keymap('n', 'gt', vim.lsp.buf.type_definition, {
                    buffer = ev.buf,
                    desc = "Jump to [D]efinition"
                })
                keymap('n', 'gr', vim.lsp.buf.references, {
                    buffer = ev.buf,
                    desc = "[G]o to [r]efrences"
                })
                keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
                    {
                        buffer = ev.buf,
                        desc = "LSP: [C]ode [A]ction"
                    })
                vim.keymap.set('n', '<space>fm', function()
                        vim.lsp.buf.format { async = true }
                    end,
                    { buffer = ev.buf, desc = "[F]or[m]at buffer" })
            end,
        })

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
        vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

        local border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
        }

        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end
    end,
}
