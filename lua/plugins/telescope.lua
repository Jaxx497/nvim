return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({

			defaults = {
				path_display = { "truncate" },
				layout_config = {
					horizontal = {
						width = 0.75,
						height = 0.8,
					},
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-[>"] = actions.close,
						["<C-h>"] = actions.close,
					},
				},
			},

			pickers = {
				colorscheme = {
					enable_preview = true,
				},
				find_files = {
					hidden = true,
					no_ignore = true
				}
			},

			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		require("telescope").load_extension("fzf")

		vim.keymap.set("n", "<leader>ff", builtin.resume, { desc = "Search Resume" })
		vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "[F]ind Files" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind [W]ord" })
		vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "[C]olor [S]cheme" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>gf", builtin.git_commits, { desc = "[Git] commits" })
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus" })
		vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind [G]it Files" })
		vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Find recently opened files" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	end,
}
