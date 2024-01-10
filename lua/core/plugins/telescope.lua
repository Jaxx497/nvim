return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				layout_config = {
					preview_width = 0.60,
					horizontal = {
						width = .75,
						height = .8
					}
				},
				mappings = {
					n = {
						["<C-[>"] = actions.close,
						["<C-h>"] = actions.close,
					},
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
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
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap.set

		keymap("n", "<leader>f", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
		keymap("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
		keymap("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
		keymap("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
		keymap("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
		keymap("n", "<leader>fr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
		keymap("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })

		keymap("n", "<leader>cs", ":Telescope colorscheme<CR>", { desc = "[C]olor [S]cheme" })
		keymap("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
		keymap("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
		keymap("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
	end,
}
