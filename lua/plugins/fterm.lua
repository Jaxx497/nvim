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

    vim.keymap.set({ "n", "v", "i", "x", "t" }, "<F5>", "<CMD>lua require('FTerm').toggle()<CR>"),
    vim.keymap.set({ "n", "v", "i", "x", "t" }, "<F6>", "<CMD>lua require('FTerm').exit()<CR>"),
    vim.keymap.set({ "n", "v" }, "<leader><space>", "<CMD>lua require('FTerm').toggle()<CR>",
        { noremap = true, silent = true })
}
