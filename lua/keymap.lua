local keymap = vim.keymap.set

-- 'KEYMAP 'KJ' TO ESC
keymap({ "c", "i", "o", "s", "v" }, "kj", "<esc>")
keymap("n", "kj", ":noh<cr><esc>", { silent = true })

-- CENTER SCREEN WHILE CYCLING SEARCH RESULTS
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- CLIPBOARD ADJUSTMENTS
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "[Y]ank line to clipboard" })

-- MOVE LINES OF CODE UP AND DOWN
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")

keymap("x", "J", ":m '>+1<CR>gv=gv")
keymap("x", "K", ":m '<-2<CR>gv=gv")
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- SCROLL & CENTER
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")

-- OPEN TERMINAL
keymap("n", "<leader>tn", ":term<CR>A", { desc = "[T]ermi[n]al" })
keymap("t", "\\", "<C-\\><C-N>k")

vim.keymap.set("n", "<leader><space>", vim.cmd.Term, { noremap = true, silent = true })
vim.keymap.set("t", "kj", "<C-\\><C-n>", { noremap = true, silent = true })

local function Term()
	local terminal_buffer_number = vim.fn.bufnr("term://")
	local terminal_window_number = vim.fn.bufwinnr("term://")
	local window_count = vim.fn.winnr("$")

	if terminal_window_number > 0 and window_count > 1 then
		vim.fn.execute(terminal_window_number .. "wincmd c")
	elseif terminal_buffer_number > 0 and terminal_buffer_number ~= vim.fn.bufnr("%") then
		vim.fn.execute("sb " .. terminal_buffer_number)
	elseif terminal_buffer_number == vim.fn.bufnr("%") then
		vim.fn.execute("bprevious | sb " .. terminal_buffer_number .. " | wincmd p")
	else
		vim.fn.execute("sp term://zsh")
	end
end

vim.api.nvim_create_user_command("Term", Term, {
	desc = "Open terminal window",
})

keymap("n", "<leader>x", ":w<CR>|<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

keymap("n", "<S-Tab>", "gf", { noremap = true, silent = true })
keymap("n", "<Tab>", "gf", { noremap = true, silent = true })

-- keymap({ "n", "i", "v", "x" }, "<C-a>", "<ESC>ggVG", { desc = "Select all" })
keymap("n", "<leader>vs", ":vsp<CR><C-w>l", { desc = "[V]ertical [S]plit" })

-- SEARCH AND REPLACE
keymap("v", "<leader>sb", 'y:%s/<C-r><C-r>"//g<Left><Left>', { desc = "[s]ubstitute current word" })
keymap("n", "<leader>sb", ":%s/<C-r><C-w>//gI<Left><Left><Left>", { desc = "[s]ubstitute current word" })

-- PLUGIN SPECIFIC
keymap("n", "<leader>tw", ":Twilight<CR>", { desc = "Activate [tw]ilight" })
keymap("n", "<leader>md", ":MarkdownPreviewToggle<CR>", { desc = "[M]ark[d]own toggle" })
