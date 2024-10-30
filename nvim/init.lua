require("keymaps")

-- Solves nvim 0.10.x bug with vscode where messages were printed in vscode output pannel
if vim.g.vscode then
	vim.opt.cmdheight = 1
	return
end

if not vim.g.vscode then
	require("defaults")
	require("plugin_manager")
	require("commands")
	require("output_buffer")
    require("winbar")
    require("colors")
	vim.g.neovide_cursor_animation_length = 0
end
