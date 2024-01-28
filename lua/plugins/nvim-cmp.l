return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",       -- source for text in buffer
        "hrsh7th/cmp-path",         -- source for system paths

        "L3MON4D3/LuaSnip",         -- snippet engine
        "saadparwaiz1/cmp_luasnip", -- for autocompletion

        "onsails/lspkind.nvim",
        "rafamadriz/friendly-snippets", -- useful snippets


        -- "hrsh7th/cmp-nvim-lsp",
        --"hrsh7th/nvim_lsp_signature_help",
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({

    end,
}
