return {
	"echasnovski/mini.nvim",
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	config = function()
		require("mini.pairs").setup()
		require('mini.surround').setup()
		require("mini.comment").setup({
			mappings = {
				comment_line = "tc",
			}
		})
	end,
}
