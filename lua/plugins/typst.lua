return {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
        -- invert_colors = 'always'
    },

    vim.keymap.set("n", "<leader>ty", ":TypstPreviewToggle<CR>", { desc = "[Ty]pst toggle" })
}
