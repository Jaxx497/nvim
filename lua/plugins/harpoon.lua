return {
	"ThePrimeagen/harpoon",
	event = "VeryLazy",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, { desc = "[H]arpoon menu toggle" })
		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "[A]dd file to harpoon menu" })

		vim.keymap.set("n", "<leader><F1>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<leader><F2>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<leader><F3>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<leader><F4>", function()
			ui.nav_file(4)
		end)
		vim.keymap.set("n", "<leader><F5>", function()
			ui.nav_file(5)
		end)
		vim.keymap.set("n", "<leader><F6>", function()
			ui.nav_file(6)
		end)
	end,
}
