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

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
    end,
})
vim.api.nvim_create_autocmd('LspDetach', { command = 'setl foldexpr < ' })

-- Fix capital letters on commands
vim.cmd [[command! W write]]
vim.cmd [[command! Wq wq]]
vim.cmd [[command! Q q]]
vim.cmd [[command! Wq wq]]

local group = vim.api.nvim_create_augroup("QuickfixPreview", { clear = true })

vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "qf" then
            local line = vim.fn.line(".")
            local qf_list = vim.fn.getqflist()

            if line <= #qf_list then
                -- Store current window
                local qf_win = vim.api.nvim_get_current_win()

                -- Try to jump to the location
                local ok = pcall(vim.cmd, "silent! " .. line .. "cc")

                if ok then
                    -- Return to quickfix window
                    vim.api.nvim_set_current_win(qf_win)
                end
            end
        end
    end,
})

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
