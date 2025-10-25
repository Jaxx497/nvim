local keymap = vim.keymap.set
-- 'KEYMAP 'kj' TO ESC
keymap({ "c", "i", "o", "s", "v" }, "kj", "<CMD>noh<CR><ESC>")

vim.keymap.set("n", "i", function()
    if #vim.fn.getline "." == 0 then
        return [["_cc]]
    else
        return "i"
    end
end, { expr = true, desc = "Automatically indent to the appropriate position" })

-- CENTER SCREEN WHILE CYCLING SEARCH RESULTS
keymap("n", "n", "nzzzv", { silent = true })
keymap("n", "N", "Nzzzv", { silent = true })

-- CLIPBOARD ADJUSTMENTS
keymap({ "n", "v" }, "<leader>y", '"+y<CR>gv', { desc = "[Y]ank to clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "[Y]ank line to clipboard" })

keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- OPEN TERMINAL
keymap("n", "<leader>tn", ":term<CR>", { desc = "Open full [T]ermi[n]al" })
keymap("n", "<A-->", "5<C-W>-")
keymap("n", "<A-=>", "5<C-W>+")
keymap("n", "<A->>", "5<C-W>>")
keymap("n", "<A-<>", "5<C-W><")

keymap("t", "kj", "<C-\\><C-n>", { noremap = true, silent = true })

-- MAKE FILE EXCECUTABLE --
keymap("n", "<leader>x", ":w<CR>|<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- GIT --
keymap("n", "<leader>gg", "<CMD>Git<CR>", { desc = "[G]it" })

-- GoTo File --	
keymap("n", "<S-Tab>", "gf", { noremap = true, silent = true })

-- SPLITTING
keymap("n", "<leader>sl", ":sp<CR><C-w>j", { desc = "[Sp]lit" })
keymap("n", "<leader>vs", ":vsp<CR><C-w>l", { desc = "[V]ertical [S]plit" })

-- SEARCH AND REPLACE
keymap("v", "<leader>sb", 'y:%s/<C-r><C-r>"//g<Left><Left>', { desc = "[S]ubstitute current word" })
keymap("n", "<leader>sb", ":%s/<C-r><C-w>//gI<Left><Left><Left>", { desc = "[S]ubstitute current word" })

-- Copy registry to clipboard
keymap("n", "<Leader>xp", ":call setreg('+', getreg('@'))<CR>", { silent = true })

keymap("n", "tc", ':normal Vgc"<Esc>', { silent = true, noremap = true })
keymap({ "n", "x", "v" }, "<Leader>tc", ':normal Vgc"<Esc>', { silent = true, noremap = true })
keymap({ "n", "x", "v" }, "<Leader>gc", ':normal gcc"<Esc>', { silent = true, noremap = true })

-- DO NOT COPY EMPTY TEXT TO REGISTER
keymap("n", "dd", function()
    if vim.fn.getline(".") == "" then
        return '"_dd'
    end
    return "dd"
end, { expr = true })
