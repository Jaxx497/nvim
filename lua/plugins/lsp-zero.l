return {
    "VonHeikemen/lsp-zero.nvim",
    event = { "BufRead", "BufNewFile" },
    branch = 'v3.x',
    dependencies = {
        -- "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "neovim/nvim-lspconfig",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
    },

    config = function()
        local lsp_zero = require('lsp-zero')
        require('lspconfig.ui.windows').default_options.border = 'rounded'

        --------------------------
        --- LSP CONFIGURATION ---
        --------------------------

        local keymap = vim.keymap.set

        -- Lsp Zero Key Bindings --
        lsp_zero.on_attach(function(_, bufnr)
            keymap('n', '<space>q', vim.diagnostic.setloclist, {
                buffer = bufnr,
                remap = false,
                desc = "Send to [q]uickfix list"
            })

            keymap('n', 'gD', vim.lsp.buf.declaration, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: [G]oto [D]eclaration"
            })

            keymap('n', 'gd', vim.lsp.buf.definition, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: [G]oto [D]efinition"
            })

            keymap('n', 'K', vim.lsp.buf.hover, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: Hover Documentation"
            })

            keymap('n', 'gi', vim.lsp.buf.implementation, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: [G]oto [I]mplementation"
            })

            keymap('n', '<leader>k', vim.lsp.buf.signature_help, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: Signature Documentation"
            })

            keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: [W]orkspace [A]dd Folder"
            })

            keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: [W]orkspace [R]emove Folder"
            })

            keymap('n', '<leader>rn', vim.lsp.buf.rename, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: [R]e[n]ame"
            })

            keymap('n', 'gt', vim.lsp.buf.type_definition, {
                buffer = bufnr,
                remap = false,
                desc = "Jump to [D]efinition"
            })

            keymap('n', 'gr', vim.lsp.buf.references, {
                buffer = bufnr,
                remap = false,
                desc = "[G]o to [r]efrences"
            })

            keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: [C]ode [A]ction"
            })

            keymap("n", "<leader>vd", function() vim.diagnostic.open_float() end, {
                buffer = bufnr,
                remap = false,
                desc = "Open [V]im [D]iagnostic float"
            })

            keymap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {
                buffer = bufnr,
                remap = false,
                desc = "Signature Help"
            })
        end)

        lsp_zero.set_sign_icons({
            error = " ",
            warn = " ",
            hint = "󰠠 ",
            info = " "
        })

        vim.diagnostic.config({
            underline = true,
            virtual_text = true,
            float = {
                show_header = true,
                source = "if_many",
                border = "rounded",
                header = 'DIAGNOSTIC',
            },
            update_in_insert = false, -- default to false
            severity_sort = true,     -- default to false
        })

        -- UFO CONFIG --
        require('ufo').setup()
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

        local lsp_capabilities = vim.tbl_deep_extend(
            'force',
            require('cmp_nvim_lsp').default_capabilities(),
            {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true
                    },
                },
            }
        )

        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            lsp_capabilities
        )

        -------------
        --- MASON ---
        -------------
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
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
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
                { name = 'luasnip', keyword_length = 2 },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                -- { name = 'buffer',  keyword_length = 3 },
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

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
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
                -- ["<S-CR>"] = cmp.mapping.confirm({ select = true }),
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
            }),
        })
    end
}
