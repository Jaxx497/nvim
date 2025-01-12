return {
    'neovim/nvim-lspconfig',
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        "williamboman/mason.nvim",
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/nvim-cmp',
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
        -- "hrsh7th/cmp-nvim-lua",
        -- "rafamadriz/friendly-snippets",
    },

    config = function()
        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

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
            end
        })

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = "󰠠 ",
                    [vim.diagnostic.severity.INFO] = " "
                }
            },
            severity_sort = true,
            virtual_text = false,
            -- virtual_text = {
            --     prefix = '',
            -- }
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
                "basedpyright",
                "clangd",
                "cssls",
                "emmet_ls",
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

        -------------------------
        --- COMPLETION ENGINE ---
        -------------------------
        local cmp = require('cmp')
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'buffer' },
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },

            formatting = {
                fields = { 'menu', 'abbr', 'kind' },

                format = function(entry, item)
                    local kind_icons = {
                        Text = "󰉿",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰜢",
                        Variable = "󰀫",
                        Class = "󰠱",
                        Interface = "",
                        Module = "",
                        Property = "󰜢",
                        Unit = "",
                        Value = "󰎠",
                        Enum = "",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "",
                        Folder = "󰉋",
                        EnumMember = "",
                        Constant = "󰏿",
                        Struct = "",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = '  ',
                    }

                    item.kind = string.format('%s %s', kind_icons[item.kind], item.kind) -- show icons with the name of the item kind

                    local MAX_LABEL_WIDTH = 35
                    local label = item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
                    if truncated_label ~= label then
                        item.abbr = truncated_label .. '…'
                    end

                    local menu_icon = {
                        nvim_lsp = 'λ',
                        luasnip = '⋗',
                        buffer = 'Ω',
                        path = '🖫',
                        nvim_lua = 'Π',
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },

            completion = {
                completeopt = "menu, menuone, preview, noselect",
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<CR>"] = cmp.mapping.confirm({
                    select = false
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })
        })

        cmp.setup.filetype({ "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            },
        })
    end
}
