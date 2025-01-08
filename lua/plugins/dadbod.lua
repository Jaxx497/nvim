return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        "tpope/vim-dadbod",
        "kristijanhusak/vim-dadbod-completion"
    },
    cmd = "DBUI",
    keys = {
        { "<leader>db", "<cmd>DBUIToggle<cr>" }
    }
}
