return {
	"nvim-neorg/neorg",
	version = "*",
	-- ft = "norg",
	-- build = ":Neorg sync-parsers",
	-- lazy = "false",
	dependencies = { "nvim-lua/plenary.nvim" },
	-- config = true,
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {
					config = {
						icon_preset = "diamond",
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes"
						},
						default_workspace = "notes"
					}
				}
				-- ["core.esupports.indent"] = {
				-- 	config = {
				-- 		format_on_enter = "false",
				-- 	},
				-- },
				--
			}
		})
		-- 	require("neorg").setup({
		-- 		load = {
		-- 			["core.esupports.indent"] = {
		-- 				config = {
		-- 					format_on_enter = "false",
		-- 				},
		-- 			},
		-- 		},
		-- 		keys = {
		-- 			vim.keymap.set(
		-- 				"n",
		-- 				"<leader>ne",
		-- 				":Neorg export to-file<CR>.md<Left><Left><Left>",
		-- 				{ desc = "[N]eorg [E]xport to file" }
		-- 			),
		-- 		},
		-- 		init_open_folds = "always",
		-- 	})
	end,
}
