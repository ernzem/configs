vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Write changes to disk
vim.keymap.set("n", "<leader>w", '<cmd>:silent write<cr>',
    { desc = 'Save Current Buffer', noremap = true, silent = true })

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

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<C-Space>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set({ "n", "v" }, "<S-L>", "$", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<S-H>", "_", { noremap = true, silent = true })
