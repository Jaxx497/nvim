return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        'williamboman/mason-lspconfig.nvim',
        "saghen/blink.cmp",
    },

    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities = vim.tbl_deep_extend(
            'force',
            capabilities,
            require('blink.cmp').get_lsp_capabilities({}, false)
        )

        capabilities = vim.tbl_deep_extend('force', capabilities, {
            textDocument = {
                onTypeFormatting = {
                    dynamicRegistration = false
                },
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true
                }
            }
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf, silent = true }

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                vim.keymap.set('n', "<leader>vd", '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
                vim.keymap.set("n", "<leader>ht",
                    "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", { silent = true })
            end
        })

        vim.diagnostic.config({
            signs = {
                -- priority = 1000,
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = "󰠠 ",
                    [vim.diagnostic.severity.INFO] = " "
                }
            },
            severity_sort = true,
            virtual_text = {
                prefix = ''
            },
            virtual_lines = false,
        })

        -- Stylizes the floating windows

        vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
        vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

        local border = {
            { '╭', "FloatBorder" },
            { '─', "FloatBorder" },
            { '╮', "FloatBorder" },
            { '│', "FloatBorder" },
            { '╯', "FloatBorder" },
            { '─', "FloatBorder" },
            { '╰', "FloatBorder" },
            { '│', "FloatBorder" },
        }

        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        require('lspconfig.ui.windows').default_options.border = 'single'

        -- Format on save!
        local buffer_autoformat = function(bufnr)
            local group = 'lsp_autoformat'
            vim.api.nvim_create_augroup(group, { clear = false })
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = bufnr,
                group = group,
                desc = 'LSP format on save',
                callback = function()
                    -- note: do not enable async formatting
                    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
                end,
            })
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(event)
                local id = vim.tbl_get(event, 'data', 'client_id')
                local client = id and vim.lsp.get_client_by_id(id)
                if client == nil then
                    return
                end

                if client.supports_method('textDocument/formatting') then
                    buffer_autoformat(event.buf)
                end
            end
        })

        -------------------------
        -- MASON CONFIGURATION --
        -------------------------

        require('mason').setup({
            ui = {
                border = "rounded",
                width = 0.5,
                height = 0.6,
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        require('mason-lspconfig').setup({
            ensure_installed = {
                "clangd",
                "cssls",
                "emmet_ls",
                "lua_ls",
                "html",
                "rust_analyzer",
                "ruff"
            },

            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            }
        })
    end
}
