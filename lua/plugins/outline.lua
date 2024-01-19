return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
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
