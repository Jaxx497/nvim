return {
	"simrat39/symbols-outline.nvim",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		require("symbols-outline").setup({
			auto_close = true,
			relative_width = false,
			width = 40,
			wrap = true,
		})
	end,
}
