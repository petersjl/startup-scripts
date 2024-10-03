vim.g.mapleader = " "

-- Normal mode
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader><leader>q", "<cmd>edit!<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "K", "i<cr><esc>l") -- split line at character (opposite of J)
vim.keymap.set("n", "<leader>s", ":%s/") -- open substitution
vim.keymap.set("n", "dp", "ddp") -- move line up one
vim.keymap.set("n", "dP", "ddkP") -- move line down one

	-- Window shortcuts
	vim.keymap.set("n", "<leader>h", "<c-w>h")
	vim.keymap.set("n", "<leader>j", "<c-w>j")
	vim.keymap.set("n", "<leader>k", "<c-w>k")
	vim.keymap.set("n", "<leader>l", "<c-w>l")

	vim.keymap.set("n", "<leader>H", "<c-w>H")
	vim.keymap.set("n", "<leader>J", "<c-w>J")
	vim.keymap.set("n", "<leader>K", "<c-w>K")
	vim.keymap.set("n", "<leader>L", "<c-w>L")

-- Insert mode
vim.keymap.set("i", "<c-p>", "<c-r>+")
vim.keymap.set("i", "<c-h>", "<c-w>") -- for some reason this is <c-backspace> to `back kill word`

-- Visual mode
vim.keymap.set("v", "<leader>s", "\"py:%s/<c-p>/")

