return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "mfussenegger/nvim-dap"
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<F6>", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<F8>", dap.continue, {})
    end
}
