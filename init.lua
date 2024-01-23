vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("keymap")
require("opts")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
        { import = "plugins" },
        { import = "plugins.lsp" },
    },
    {
        install = {
            colorscheme = { "base16-colorscheme" },
        },
        checker = {
            enabled = true,
            notify = false,
        },
        change_detection = {
            notify = false,
        },
        ui = {
            border = "rounded",
            size = {
                width = 0.4,
                height = 0.6,
            },
        },
    })

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

print("May the Lord Bless this sesh!!")
