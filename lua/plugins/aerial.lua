return {
	"stevearc/aerial.nvim",
	config = function()
		require("aerial").setup({
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
			-- layout = {
			-- 	width = 0.2,
			-- 	default_direction = "float",
			-- },
			-- float = {
			--
			-- 	relative = "win",
			-- },

			backends = { "treesitter", "lsp", "markdown", "man" },

			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Module",
				"Method",
				"Object",
				"Struct",
			},
			show_guides = true,

			guides = {
				-- When the child item has a sibling below it
				mid_item = "├─",
				-- When the child item is the last in the list
				last_item = "└─",
				-- When there are nested child guides to the right
				nested_top = "│ ",
				-- Raw indentation
				whitespace = "  ",
			},
		})
	end,
	-- vim.keymap.set("n", "<leader>ar", "<cmd>AerialToggle!<CR>"),
}
