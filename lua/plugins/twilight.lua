return {
	"folke/twilight.nvim",
	event = "VeryLazy",
	opts = {
		dimming = {
			alpha = 0.10,
			inactive = true,
		},
		expand = {

			"class",
		},
	},
	vim.keymap.set("n", "<leader>tw", ":Twilight<CR>", { desc = "Activate [tw]ilight" })
}
