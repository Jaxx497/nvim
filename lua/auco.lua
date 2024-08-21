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


-- Fix remaps
vim.cmd [[command! W write]]
vim.cmd [[command! Wq wq]]

vim.cmd [[command! Q q]]
vim.cmd [[command! Wq wq]]
