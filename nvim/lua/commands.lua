local augroup = vim.api.nvim_create_augroup

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
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
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
