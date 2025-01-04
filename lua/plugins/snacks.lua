return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        animate = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        terminal = {
            win = {
                position = "float",
                style = "terminal",
                border = "rounded",
                width = 0.6,
                height = 0.7,
            }
        },
        notifier = { enabled = true },
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 10, total = 250 },
                easing = "linear",
            },
        },
        styles = {
            notification = {
                wo = {
                    wrap = true
                }
            },
            zen = {
                enter = true,
                fixbuf = false,
                minimal = true,
                width = 80,
                height = 30,
                backdrop = { transparent = true, blend = 80 },
                keys = { q = false },
                wo = {
                    winhighlight = "NormalFloat:Normal",
                },
            }
        },
    },
    -- Keybindings --
    keys = {
        { "<leader>z",  function() Snacks.zen() end,           desc = "Toggle zen mode" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },

    vim.keymap.set({ "n", "t" }, "<leader><space>", toggle_term, { desc = "Toggle Centered ZSH Terminal" }),
    vim.keymap.set({ "n", "t" }, "<F5>", toggle_term, { desc = "Toggle Centered ZSH Terminal" }),

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>tw")
            end,
        })
    end,
}
