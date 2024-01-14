if vim.fn.exists("$VIRTUAL_ENV") == 1 then
	vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "",
		"g")
else
	vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which python3"), "\n", "", "g")
end

local set = vim.opt

-- Numbers
set.number = true
set.relativenumber = true

set.encoding = "utf-8"

set.conceallevel = 3
--set.concealcursor = "n"

vim.opt.guicursor = {
	"v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	'i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
	'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100'
}

-- Indentation
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.linebreak = true
set.autoindent = true
set.breakindent = true

-- Searching
set.ignorecase = true
set.smartcase = true
set.incsearch = true

set.mouse = "a"
set.scrolloff = 10
set.sidescrolloff = 8
set.cursorline = true

-- set.foldmethod = "indent"
--
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldtext = "v:lua.vim.treesitter.foldtext()"
set.foldenable = false
set.foldlevel = 99

set.virtualedit = "block"
set.inccommand = "split"

set.visualbell = true
set.timeoutlen = 150
set.updatetime = 150
set.termguicolors = true

set.signcolumn = "yes"

set.splitbelow = true
set.splitright = true

set.completeopt = { "menuone", "noselect", "noinsert" }
set.shortmess = set.shortmess + { c = true }

vim.cmd([[
    syntax on
    syntax enable

    set signcolumn=yes
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
