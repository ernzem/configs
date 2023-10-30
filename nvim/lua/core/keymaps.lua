-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Go through file tree
vim.keymap.set("n", "<leader>pv", '<cmd>Lexplore<cr>')

-- Paste without loosing  clipboard item
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Move selected lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Replace command for the word under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Close current buffer
vim.keymap.set("n", "<leader>q", '<cmd>bd%<cr>')
-- Open project in neovim under new tmux window
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.cfg/scripts/tmux-sessionizer<CR>")

-- vim.keymap.set("n", "<C-J>", '<C-W><C-J>')
-- vim.keymap.set("n", "<C-H>", '<C-W><C-H>')
-- vim.keymap.set("n", "<C-K>", '<C-W><C-K>')
-- vim.keymap.set("n", "<C-L>", '<C-W><C-L>')

vim.keymap.set("n", "<C-H>", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "<C-K>", [[<cmd>horizontal resize -2<cr>]])
vim.keymap.set("n", "<C-J>", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "<C-L>", [[<cmd>vertical resize +5<cr>]])

-- Disable
vim.keymap.set("n", "Q", "<nop>")
