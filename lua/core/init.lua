require("core.keymap")
require("core.opts")

vim.diagnostic.config({
	underline = true,
	signs = true,
	virtual_text = false,
	float = {
		show_header = true,
		source = "if_many",
		border = "rounded",
		focusable = false,
	},
	update_in_insert = false, -- default to false
	severity_sort = false, -- default to false
})
