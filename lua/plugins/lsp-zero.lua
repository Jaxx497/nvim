return {
    "VonHeikemen/lsp-zero.nvim",
    event = { "BufRead", "BufNewFile" },
    branch = 'v3.x',
    dependencies = {
        "hrsh7th/cmp-buffer",
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
            keymap("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>", {
                buffer = bufnr,
                remap = false,
                desc = "LSP: Show buffer diagnostics"
            })

            keymap('n', '<space>q', vim.diagnostic.setloclist, {
                buffer = bufnr,
                remap = false,
                desc = "Send to [q]uickfix list"
            })

            keymap('n', '[d', vim.diagnostic.goto_prev, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: Go to previous diagnostic"
            })

            keymap('n', ']d', vim.diagnostic.goto_next, {
                buffer = bufnr,
                remap = false,
                desc = "LSP: Go to next diagnostic"
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

            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {
                buffer = bufnr,
                remap = false,
                desc = "Open [V]im [D]iagnostic float"
            })

            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {
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


        -- Floating border --
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

        vim.g.rustaceanvim = {
            server = {
                capabilities = lsp_zero.get_capabilities(),
                on_attach = function(client, bufnr)
                    vim.lsp.inlay_hint.enable(bufnr, true)
                end,
            },
        }

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
                "clangd",
                "html",
                "cssls",
                "emmet_ls",
                "lua_ls",
                "pyright",
                -- "rust_analyzer",
            },
            handlers = {
                lsp_zero.default_setup,
                rust_analyzer = lsp_zero.noop,
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
                { name = 'buffer',  keyword_length = 3 },
                { name = 'nvim_lua' },
            },

            formatting = {
                fields = { 'menu', 'abbr', 'kind', },

                -- here is where the change happens
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
                ["<S-<CR>>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
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
