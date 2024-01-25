return {
	"hedyhli/outline.nvim",
	lazy = true,
	event = "VeryLazy",
	cmd = { "Outline", "OutlineOpen" },
	keys = {
		{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
	},
	opts = {
		auto_close = true,
		auto_jump = true,
		keymaps = {
			goto_and_close = "<Cr>",
		},
	},
}
