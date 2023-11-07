return {
	"Pocco81/true-zen.nvim",

	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("true-zen").setup({

			integrations = {
				twilight = true, -- enable twilight (ataraxis)
				lualine = true, -- hide nvim-lualine (ataraxis)
			},
		})
	end,

	vim.api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", { desc = "Zen - Narrow" }),
	vim.api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", { desc = "Zen - Focus (Close Windows)" }),
	vim.api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", { desc = "Zen - Mimimal" }),
	vim.api.nvim_set_keymap("n", "<leader>z", ":TZAtaraxis<CR>", { desc = "Zen - Super minimal mode" }),
}
