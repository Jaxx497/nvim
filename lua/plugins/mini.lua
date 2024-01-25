return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require('mini.surround').setup()
		require("mini.pairs").setup()
		require("mini.comment").setup({
			mappings = {
				comment_line = "tc",
			}
		})
	end,
}
