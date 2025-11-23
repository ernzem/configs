require("keymaps")

-- Solves nvim 0.10.x bug with vscode where messages were printed in vscode output pannel
if vim.g.vscode then
	vim.opt.cmdheight = 1
	return
end

-------------------- Initialize Lazy plugin manager -----------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", { change_detection = { notify = false } })
-------------------------------------------------------------------------
require("colors")
require("defaults")
require("commands")
require("winbar")
require("statusline")
