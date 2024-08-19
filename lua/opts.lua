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
	"i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

-- Indentation
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.linebreak = true
set.autoindent = true

-- Wrapping
set.showbreak = "↪ "
set.breakindent = true
set.breakindentopt = "shift:2"

-- Searching
set.ignorecase = true
set.smartcase = true
set.incsearch = true

set.mouse = "a"
set.scrolloff = 8
set.sidescrolloff = 8
set.cursorline = true

set.foldmethod = "indent"
-- Folding
set.foldlevel = 99
set.foldcolumn = "0"
set.foldenable = false
set.foldmethod = "indent"
-- set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- set.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.o.fillchars = [[eob:~,fold: ,foldopen:󰄼,foldsep:│,foldclose:󰄾]]

set.virtualedit = "block"
set.inccommand = "split"
set.visualbell = true
set.timeoutlen = 200
set.updatetime = 200
set.termguicolors = true
set.autoread = true
set.laststatus = 3

set.splitbelow = true
set.splitright = true

set.completeopt = { "menu", "menuone", "noselect", "noinsert" }
set.shortmess = set.shortmess + { c = true }

vim.cmd([[
    syntax on
    syntax enable

    set browsedir=buffer
]])
