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

vim.api.nvim_create_autocmd('TermOpen',
	{
		desc = "Make a clean terminal environment",
		command = 'startinsert | set nonumber norelativenumber signcolumn=no'
	})

vim.api.nvim_create_autocmd(
	'BufRead', {
		desc = "Make a clean terminal environment",
		command = 'set number relativenumber signcolumn=yes'
	})

local function Term()
	local terminal_buffer_number = vim.fn.bufnr("term://")
	local terminal_window_number = vim.fn.bufwinnr("term://")
	local window_count = vim.fn.winnr("$")

	if terminal_window_number > 0 and window_count > 1
	then
		vim.fn.execute(terminal_window_number .. "wincmd c")
	elseif terminal_buffer_number > 0 and terminal_buffer_number ~= vim.fn.bufnr("%") then
		vim.fn.execute("sb " .. terminal_buffer_number)
	elseif terminal_buffer_number == vim.fn.bufnr("%")
	then
		vim.fn.execute("bprevious | sb " .. terminal_buffer_number .. " | wincmd p")
	else
		vim.fn.execute("sp term://zsh")
	end
end

vim.api.nvim_create_user_command("Term", Term, {
	desc = "Open terminal window",
})

vim.cmd [[ autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false }) ]]
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
