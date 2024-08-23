return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = "VeryLazy",

    opts = {
        provider_selector = function(bufnr, filetype, buftype)
            return { "lsp", "indent" }
        end,
    },

    init = function()
        vim.keymap.set('n', 'zR', function() require('ufo').openAllFolds() end)
        vim.keymap.set('n', 'zM', function() require('ufo').closeAllFolds() end)
    end

    -- config = function()
    --     require("ufo").setup({
    --         provider_selector = function(bufnr, filetype, buftype)
    --             return { "lsp", "indent" }
    --         end,
    --     })
    -- end,

    -- keys = {
    --     { "n", "zR", require("ufo").openAllFolds },
    --     { "n", "zM", require("ufo").closeAllFolds }
    -- },
    --
    -- vim.keymap.set('n', 'zR', require('ufo').openAllFolds),
    -- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
}
