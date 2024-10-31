local augroup = vim.api.nvim_create_augroup
local set = vim.opt_local

-- NOTE: Might not be needed with nvim 0.12
-- Triger `autoread` when files changes on disk.
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
})

-- Trim trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("TrimTrailingWhitespaces", {}),
	desc = "trim whitespaces",
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight-yank", { clear = true }),
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = augroup("terminal-new-buffer", { clear = true }),
	desc = "Open terminal in insert mode, turn off line numbers",
	callback = function()
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0
		vim.cmd.startinsert()
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
	group = augroup("enter-terminal-buffer", { clear = true }),
    pattern = "term://*",
	desc = "Go to insert mode when entering terminal buffer",
	callback = function()
		vim.cmd.startinsert()
	end,
})

vim.api.nvim_create_user_command("NrColumnToggle", function()
	if not vim.opt.nu then
		return
	end

	if vim.opt.relativenumber._value then
		vim.opt.relativenumber = false
	else
		vim.opt.relativenumber = true
	end
end, {})
