-- Mark 0 goes back to last open buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark =
            vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] >
            1 and
            mark[1] <=
            vim.api.nvim_buf_line_count(0)
        then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "* !silent" },
})

-- Change dimming color
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    callback = function()
        vim.api.nvim_set_hl(0, "SnacksDim", { fg = '#242424', italic = true })
    end
})

-- Fix capital letters on commands
vim.cmd [[command! W write]]
vim.cmd [[command! Wq wq]]
vim.cmd [[command! Q q]]
vim.cmd [[command! Wq wq]]


toggle_term = function()
    -- Check if we're in terminal mode
    local in_terminal = vim.bo.buftype == "terminal"
    if in_terminal then
        -- Hide the terminal if we're in terminal mode
        vim.cmd("hide")
    else
        Snacks.terminal.toggle("zsh", {
            env = {
                TERM = "xterm-256color",
            },
        })
    end
end
