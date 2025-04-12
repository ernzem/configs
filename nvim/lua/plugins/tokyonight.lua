return {
	"folke/tokyonight.nvim",
	-- event = "VeryLazy",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm",
		on_colors = function(colors)
			if vim.o.background == "light" then
				-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_day.lua
				colors.bg = "#ffffff"
				colors.bg = "#ffffff"
			end
		end,
	},
	config = function()
		vim.cmd.colorscheme("tokyonight-storm")
		-- vim.cmd.colorscheme("tokyonight-day")
	end,
}
