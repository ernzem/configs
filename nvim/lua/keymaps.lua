-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Write changes to disk
-- vim.keymap.set({ "n", "i" }, "<C-s>", '<cmd>:w<cr>', { desc = 'Save Current Buffer' })

-- Disable copying on certain commands
vim.keymap.set({ "x" }, "<leader>p", [["_dP]])
vim.keymap.set({ "n", "x" }, "d", '"_d')
vim.keymap.set({ "n", "x" }, "dd", '"_dd')
vim.keymap.set({ "n", "x" }, "c", '"_c')
vim.keymap.set({ "n", "x" }, "cc", '"_cc')

-- Move selected lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Replace command for the word under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Close current buffer
vim.keymap.set("n", "<leader>q", '<cmd>bd%<cr>')
vim.keymap.set("n", "<C-Q>", '<cmd>bd!%<cr>')

-- Jump between window splits
vim.keymap.set("n", "<C-J>", '<C-W><C-J>')
vim.keymap.set("n", "<C-H>", '<C-W><C-H>')
vim.keymap.set("n", "<C-K>", '<C-W><C-K>')
vim.keymap.set("n", "<C-L>", '<C-W><C-L>')

-- Resize splits
vim.keymap.set("n", "<C-S-H>", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "<C-S-K>", [[<cmd>horizontal resize -2<cr>]])
vim.keymap.set("n", "<C-S-J>", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "<C-S-L>", [[<cmd>vertical resize +5<cr>]])

-- Disable
vim.keymap.set("n", "Q", "<nop>")

-- Terminal exit mapping
-- vim.keymap.set('t', '<C->', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Run wezterm sessionizer script
vim.keymap.set("n", "<leader>rp",
    '<cmd>silent !wezterm cli split-pane --percent 25 -- sh ~/.cfg/scripts/wezterm-sessionizer.sh<cr>')
