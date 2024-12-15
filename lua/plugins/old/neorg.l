return {
	"nvim-neorg/neorg",
	version = "*",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {
					config = {
						icon_preset = "diamond",
						icons = {
							list = {}
						}
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes"
						},
						default_workspace = "notes"
					}
				},
				["core.esupports.indent"] = {
					config = {
						format_on_enter = "false",
					},
				},
			}
		})
		vim.wo.conceallevel = 2
	end,
}
