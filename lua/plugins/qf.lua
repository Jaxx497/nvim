return {
    'kevinhwang91/nvim-bqf',
    event = "VeryLazy",
    dependencies = {
        'junegunn/fzf',
        run = function()
            vim.fn['fzf#install']()
        end,

        { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
    },

    opts = {
        magic_window = true,
        preview = {
            border = "rounded",
            winblend = 0,
            show_scroll_bar = false,
            win_height = 999
        }
    },

    vim.keymap.set("n", "<leader>q",
        function()
            local qf_winid = vim.fn.getqflist({ winid = 0 }).winid

            if qf_winid ~= 0 then
                vim.cmd("cclose")
            else
                vim.diagnostic.setqflist()
                vim.cmd("copen")
            end
        end,

        { desc = "Send diagnostics to quickfix list" })

}
