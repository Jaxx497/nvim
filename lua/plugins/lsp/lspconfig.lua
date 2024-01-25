return {
	"neovim/nvim-lspconfig",

	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},

	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap.set

		local opts = { noremap = true, silent = true }
		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			keymap("n", "<leader>rs", ":LspRestart<CR>", { desc = "LSP: Restart LSP" })
			keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
			keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" })
			keymap("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition" })
			keymap("n", "gr", require("telescope.builtin").lsp_references, { desc = "LSP: [G]oto [R]eferences" })
			keymap(
				"n",
				"gi",
				require("telescope.builtin").lsp_implementations,
				{ desc = "LSP: [G]oto [I]mplementation" }
			)
			keymap("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP: Type [D]efinition" })
			keymap(
				"n",
				"<leader>ds",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "LSP: [D]ocument [S]ymbols" }
			)
			keymap(
				"n",
				"<leader>ws",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				{ desc = "LSP: [W]orkspace [S]ymbols" }
			)

			-- See `:help K` for why this keymap
			keymap("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation" })
			keymap("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation" })

			-- Lesser used LSP functionality
			keymap("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration" })
			keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP: [W]orkspace [A]dd Folder" })
			keymap(
				"n",
				"<leader>wr",
				vim.lsp.buf.remove_workspace_folder,
				{ desc = "LSP: [W]orkspace [R]emove Folder" }
			)

			keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: See available code actions" }) -- see available code actions, in visual mode will apply to selection
			keymap(
				"n",
				"<leader>D",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				{ desc = "LSP: Show buffer diagnostics" }
			)                                                                                   -- show  diagnostics for file
			keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "LSP: Show line diagnostics" }) -- show diagnostics for line
			keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Go to previous diagnostic" }) -- jump to previous diagnostic in buffer
			keymap("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Go to next diagnostic" }) -- jump to next diagnostic in buffer
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local border = {
			{ "🭽", "FloatBorder" },
			{ "▔", "FloatBorder" },
			{ "🭾", "FloatBorder" },
			{ "▕", "FloatBorder" },
			{ "🭿", "FloatBorder" },
			{ "▁", "FloatBorder" },
			{ "🭼", "FloatBorder" },
			{ "▏", "FloatBorder" },
		}

		-- LSP settings (for overriding per client)
		-- local handlers = {
		-- 	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		-- 	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		-- }
		--
		-- Do not forget to use the on_attach function
		require("lspconfig")

		-- To instead override globally
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or border
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["html"].setup({
			capabilities = capabilities,
		})

		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
