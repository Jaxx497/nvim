return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		window = {
			border = "single",
			margin = { 1, 20, 1, 20 },
		},
		layout = {
			spacing = 5,
			align = "center",
		},
	},
}
