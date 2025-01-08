return {
    "kndndrj/nvim-dbee",
    cmd = "Dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    build = function()
        require("dbee").install()
    end,

    config = function()
        local dbee = require("dbee")
        dbee.setup({
            result = {
                page_size = 1000
            }
        })
    end,
}
