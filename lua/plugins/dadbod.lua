return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        "tpope/vim-dadbod",
        "kristijanhusak/vim-dadbod-completion"
    },
    cmd = "DBUI",
    keys = {
        { "<leader>db", "<cmd>DBUIToggle<cr>" }
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
    end
}
