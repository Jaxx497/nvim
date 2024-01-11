return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			css = { "stylelint" },
			javascript = { "eslint_d" },
			python = { "flake8" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "leader>li", function()
			lint.try_lint()
		end, { desc = "Trigger [Li]nting for current file" })
	end,
}
