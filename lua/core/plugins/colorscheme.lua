return {
	-- "tanvirtin/monokai.nvim",
	-- "tomasr/molokai",
	-- "Yazeed1s/minimal.nvim",
	--
	-- "kajamite/vim-monokai2",
	--
	-- {
	-- 	"srcery-colors/srcery-vim",
	-- 	name = "srcery",
	-- 	-- keys = { "<leader>w" },
	-- 	cmd = "Telescope",
	-- },
	--
	{
		"RRethy/nvim-base16",
		priority = 1000,
		config = function()
			require("base16-colorscheme").with_config({
				cmp = false,
				telescope = false,
			})
			vim.cmd.colorscheme("base16-tokyo-city-terminal-dark")
		end,
	},
}
