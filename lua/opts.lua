local set = vim.opt

-- Numbers
set.number = true
set.relativenumber = true
set.showmode = false
set.shortmess = "ltToOCFS"

set.encoding = "utf-8"

set.conceallevel = 3
--set.concealcursor = "n"

vim.opt.guicursor = {
    "v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
    "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
    "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

-- Indentation
set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4
set.linebreak = true
set.autoindent = true
set.signcolumn = "yes"

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

-- Folding
set.foldenable = false
set.foldlevel = 99
set.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexper()"
set.foldcolumn = '0'
vim.o.fillchars = [[eob:~,fold: ,foldopen:󰄼,foldclose:󰄾,foldsep: ]]

set.virtualedit = "block"
set.inccommand = "split"
set.visualbell = true
set.timeoutlen = 200
set.updatetime = 200
set.termguicolors = true
set.autoread = true
set.laststatus = 3

set.winborder = 'rounded'

set.splitbelow = true
set.splitright = true

set.grepprg = "rg --vimgrep --smart-case"
set.grepformat = "%f:%l:%c:%m"

set.completeopt = { "menu", "menuone", "noselect", "noinsert" }
set.shortmess = set.shortmess + { c = true }


vim.cmd([[
    syntax on
    syntax enable
]])
