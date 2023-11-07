if vim.fn.exists("$VIRTUAL_ENV") == 1 then
	vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
	vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which python3"), "\n", "", "g")
end

local set = vim.opt

set.number = true
set.relativenumber = true

set.autoindent = true
set.encoding = "utf-8"
set.linebreak = true

set.cole = 3
set.cocu = "n"
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.breakindent = true

set.ignorecase = true
set.smartcase = true
set.incsearch = true

set.mouse = "a"
set.cursorline = true
set.scrolloff = 5
set.sidescrolloff = 8
set.foldmethod = "indent"

set.termguicolors = true
set.visualbell = true
set.timeoutlen = 150
set.updatetime = 150

set.signcolumn = "yes"

set.completeopt = { "menuone", "noselect", "noinsert" }
set.shortmess = set.shortmess + { c = true }

vim.cmd([[
    syntax on
    syntax enable
    
    set signcolumn=yes
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
