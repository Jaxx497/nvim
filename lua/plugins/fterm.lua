return {
    "numToStr/FTerm.nvim",

    config = function()
        require("FTerm").setup({
            border = "rounded",
            dimensions = {
                height = 0.7,
                width = 0.7
            }
        })
    end,

    vim.keymap.set({ "n", "v" }, "<F5>", "<CMD>lua require('FTerm').toggle()<CR>"),
    vim.keymap.set({ "n", "v" }, "<leader><space>", "<CMD>lua require('FTerm').toggle()<CR>",
        { noremap = true, silent = true })
}
