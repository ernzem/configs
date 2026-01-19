return {
	"folke/tokyonight.nvim",
	-- event = "VeryLazy",
	-- lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "storm",
			styles = {
				keywords = { italic = false },
			},
			day_brightness = 0.1,
		})

		vim.cmd.colorscheme("tokyonight-storm")
		-- vim.cmd.colorscheme("tokyonight-day")
	end,
}
