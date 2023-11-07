return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	lazy = true,
	config = function()
		vim.fn["mkdp#util#install"]()
		vim.g.mkdp_auto_close = true
		vim.g.mkdp_open_to_the_world = false
		vim.g.mkdp_open_ip = "127.0.0.1"
		vim.g.mkdp_port = "8888"
		vim.g.mkdp_browser = "firefox"
		vim.g.mkdp_echo_preview_url = true
		vim.g.mkdp_page_title = "${name}"
		vim.g.mkdp_markdown_css = "/home/jack/.config/nvim/xtra/globals.css"
	end,
}
