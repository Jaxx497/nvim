return {
	"folke/twilight.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		dimming = {
			alpha = 0.10,
			inactive = true,
		},
		expand = {

			"class",
		},
	},
}
