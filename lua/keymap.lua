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

keymap("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- SCROLL & CENTER
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")

-- OPEN TERMINAL
keymap("n", "<leader>tn", ":term<CR>", { desc = "Open full [T]ermi[n]al" })
keymap("t", "\\", "<C-\\><C-N>k")

keymap("n", "<leader><space>", vim.cmd.Term, { noremap = true, silent = true })
keymap("t", "kj", "<C-\\><C-n>", { noremap = true, silent = true })

-- MAKE FILE EXCECUTABLE --
keymap("n", "<leader>x", ":w<CR>|<cmd>!chmseed +x %<CR>", { silent = true, desc = "Make file executable" })

-- GoTo File --	
keymap("n", "<S-Tab>", "gf", { noremap = true, silent = true })

-- SPLITTING
keymap("n", "<leader>sp", ":sp<CR><C-w>j", { desc = "[Sp]lit" })
keymap("n", "<leader>vs", ":vsp<CR><C-w>l", { desc = "[V]ertical [S]plit" })

-- SEARCH AND REPLACE
keymap("v", "<leader>sb", 'y:%s/<C-r><C-r>"//g<Left><Left>', { desc = "[s]ubstitute current word" })
keymap("n", "<leader>sb", ":%s/<C-r><C-w>//gI<Left><Left><Left>", { desc = "[s]ubstitute current word" })

-- Copy registry to clipboard
keymap("n", "<Leader>xp", ":call setreg('+', getreg('@'))<CR>")

-- DO NOT COPY EMPTY TEXT TO REGISTER
keymap("n", "dd", function()
	if vim.fn.getline(".") == "" then
		return '"_dd'
	end
	return "dd"
end, { expr = true })

-- PREVIOUS BUFFER SHORTCUT
keymap("n", "<BS>", "<C-o>")
