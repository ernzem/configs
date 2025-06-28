local key = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Write changes to disk
key.set("n", "<leader>w", "<cmd>:silent write<cr>", { desc = "Save Current Buffer", noremap = true, silent = true })

-- Disable copying on certain commands
key.set({ "x" }, "<leader>p", [["_dP]])
key.set({ "n", "x" }, "d", '"_d')
key.set({ "n", "x" }, "dd", '"_dd')
key.set({ "n", "x" }, "c", '"_c')
key.set({ "n", "x" }, "cc", '"_cc')

-- Move selected lines in visual mode
key.set("v", "J", ":m '>+1<CR>gv=gv")
key.set("v", "K", ":m '<-2<CR>gv=gv")

-- Replace command for the word under the cursor
key.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Close current buffer
key.set("n", "<leader>q", "<cmd>bd%<cr>")
key.set("n", "<C-Q>", "<cmd>bd!%<cr>")

-- Jump between window splits
key.set("n", "<C-j>", "<C-W><C-J>")
key.set("n", "<C-h>", "<C-W><C-H>")
key.set("n", "<C-k>", "<C-W><C-K>")
key.set("n", "<C-l>", "<C-W><C-L>")

-- Resize splits
key.set("n", "<C-S-H>", [[<cmd>vertical resize -5<cr>]])
key.set("n", "<C-S-K>", [[<cmd>horizontal resize -2<cr>]])
key.set("n", "<C-S-J>", [[<cmd>horizontal resize +2<cr>]])
key.set("n", "<C-S-L>", [[<cmd>vertical resize +5<cr>]])

-------------------------------- Commenting keymaps --------------------------------------
local comment_line = function()
	return require("vim._comment").operator() .. "_"
end
local comment_line_in_insert = function()
	return "<cmd>stopinsert<cr>" .. comment_line() .. "<cmd>startinsert<cr>"
end

key.set({"n", "v"}, "<C-/>", comment_line, { expr = true, desc = "Toggle comment line" })
key.set("i", "<C-/>", comment_line_in_insert, { expr = true, desc = "Toggle comment line" })
----------------------------------------------------------------------------------------------

key.set("n", "<C-space>", ":", { desc = "Enter command" })
key.set("n", "<C-;>", ":!", { desc = "Run shell command" })

key.set("i", "<C-j>", "<ESC>", { desc = "Exit insert mode" })
key.set("t", "<C-j>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Print git branch name in buffer
key.set(
	{ "n", "i" },
	"<C-S-B>",
	'<ESC>:silent .-1r !echo "$(git rev-parse --abbrev-ref HEAD)" | grep -E -o "^[A-Z]+-[0-9]+"<CR>g_:startinsert!<CR>'
)

key.set("n", "<leader>ih", function()
	local result = vim.treesitter.get_captures_at_cursor(0)
	print(vim.inspect(result))
end, { noremap = true, silent = false, desc = "Print highlight name under cursor" })


local function toggle_relative_line_nrs()
	if not vim.opt.nu then
		return
	end

	if vim.opt.relativenumber._value then
		vim.opt.relativenumber = false
	else
		vim.opt.relativenumber = true
	end
end
key.set({ "n", "i", "t" }, "<F1>", toggle_relative_line_nrs, {noremap = true, desc = "Toggle between relative and actual line numbers"})
