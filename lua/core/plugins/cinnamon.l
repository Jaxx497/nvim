return {
	"declancm/cinnamon.nvim",

	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		require("cinnamon").setup({
			default_delay = 8,
		})
	end,
}
