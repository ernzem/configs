vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Write changes to disk
vim.keymap.set(
    "n",
    "<leader>w",
    "<cmd>:silent write<cr>",
    { desc = "Save Current Buffer", noremap = true, silent = true }
)

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
vim.keymap.set("n", "<leader>q", "<cmd>bd%<cr>")
vim.keymap.set("n", "<C-Q>", "<cmd>bd!%<cr>")

-- Jump between window splits
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")

-- Resize splits
vim.keymap.set("n", "<C-S-H>", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "<C-S-K>", [[<cmd>horizontal resize -2<cr>]])
vim.keymap.set("n", "<C-S-J>", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "<C-S-L>", [[<cmd>vertical resize +5<cr>]])

-- Disable
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({ "n", "i" }, "<F1>", "<nop>")

-- Print git branch name in buffer
vim.keymap.set(
    { "n", "i" },
    "<C-S-B>",
    '<ESC>:silent .-1r !echo "$(git rev-parse --abbrev-ref HEAD)" | grep -E -o "^[A-Z]+-[0-9]+"<CR>g_:startinsert!<CR>'
)

vim.keymap.set("n", "<leader>ih",
    function()
        local result = vim.treesitter.get_captures_at_cursor(0)
        print(vim.inspect(result))
    end,
    { noremap = true, silent = false }
)
