return {
  "VonHeikemen/lsp-zero.nvim",
  branch = 'v3.x',
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "neovim/nvim-lspconfig",
    "onsails/lspkind.nvim",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
  },

  config = function()
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")
    local lsp_zero = require('lsp-zero')
    require('lspconfig.ui.windows').default_options.border = 'rounded'

    --------------------------
    --- LSP CONFIGURATION ---
    --------------------------

    local keymap = vim.keymap.set

    lsp_zero.on_attach(function(client, bufnr)
      -- local opts = { buffer = bufnr, remap = false }

      keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>",
        {
          buffer = bufnr,
          remap = false,
          desc = "LSP: Show buffer diagnostics"
        })

      keymap('n', '<space>q', vim.diagnostic.setloclist,
        {
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

    -- Diagnostic signs in sign column
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Floating border
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
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
      },
      formatting = {
        format = lspkind.cmp_format({

          mode = 'symbol_text',
          maxwidth = 50,
          -- can also be a function to dynamically calculate max width such as
          -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
          ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          -- before = function(entry, vim_item)
          --   return vim_item
          -- end
        })
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
        completion = cmp.config.window.bordered({
          border = "rounded",
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
        }),
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



-- ORIGINAL LSPZERO CONFIG MAPPINGS
-- lsp_zero.on_attach(function(client, bufnr)
--   local opts = {buffer = bufnr, remap = false}
--
--   vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--   vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--   vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--   vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--   vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--   vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--   vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--   vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--   vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--   vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- end)
