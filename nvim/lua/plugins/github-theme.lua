return {
	"projekt0n/github-nvim-theme",
	-- lazy = false,
	-- priority = 1000,
	event = "VeryLazy",
	opts = {
		options = {
			hide_nc_statusline = false, -- Override the underline style for non-active statuslines
			terminal_colors = true,
			dim_inactive = false,
		},

		palettes = {
			github_light = {
				inactive = '#EEEEEE', -- not working at the moment
			},
		},

		-- specs = {
		-- 	github_light_high_contrast = {
		-- 		inactive = "#eeeeee",
		-- 	},
		-- 	github_light = {
		-- 		inactive = "#eeeeee",
		-- 	},
		-- },

		groups = {
			github_light_high_contrast = {
		-- 		NormalNC = { bg = "inactive" }, -- Non-current windows
				-- StatusLine = { bg = "#eeeeee" },
				StatusLineNC = { bg = 'inactive' },

			},
		},
	},
	config = function()
		-- vim.cmd("colorscheme github_light")
	end,
}
