return {
    'mrjones2014/smart-splits.nvim',
    config = function()
        -- vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
        -- vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
        -- vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
        -- vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
        -- moving between splits
        vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
        vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
        vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
        vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
        -- swapping buffers between windows
        vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
        vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
        vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
        vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
    end,

}


-- {
-- 	'numToStr/Navigator.nvim',
-- 	config = function()
-- 		require('Navigator').setup()
-- 	end,
-- 	vim.keymap.set({ 'n', 't' }, '<C-h>', '<CMD>NavigatorLeft<CR>'),
-- 	vim.keymap.set({ 'n', 't' }, '<C-l>', '<CMD>NavigatorRight<CR>'),
-- 	vim.keymap.set({ 'n', 't' }, '<C-k>', '<CMD>NavigatorUp<CR>'),
-- 	vim.keymap.set({ 'n', 't' }, '<C-j>', '<CMD>NavigatorDown<CR>'),
-- 	vim.keymap.set({ 'n', 't' }, '<C-p>', '<CMD>NavigatorPrevious<CR>'),
-- 	-- vim.keymap.set({ 'n', 't' }, '<A-h>', '<CMD>NavigatorLeft<CR>'),
-- 	-- vim.keymap.set({ 'n', 't' }, '<A-l>', '<CMD>NavigatorRight<CR>'),
-- 	-- vim.keymap.set({ 'n', 't' }, '<A-k>', '<CMD>NavigatorUp<CR>'),
-- 	-- vim.keymap.set({ 'n', 't' }, '<A-j>', '<CMD>NavigatorDown<CR>'),
-- 	-- vim.keymap.set({ 'n', 't' }, '<A-p>', '<CMD>NavigatorPrevious<CR>'),
-- }

-- {
-- "christoomey/vim-tmux-navigator",
-- event = "VeryLazy",
-- cmd = {
-- 	"TmuxNavigateLeft",
-- 	"TmuxNavigateDown",
-- 	"TmuxNavigateUp",
-- 	"TmuxNavigateRight",
-- 	"TmuxNavigatePrevious",
-- },
-- keys = {
-- 	{ "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
-- 	{ "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
-- 	{ "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
-- 	{ "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
-- 	{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
-- },
-- }
--
