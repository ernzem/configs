return {
	"catppuccin/nvim",
	name = "catppuccin",
	event = "VeryLazy",
	-- lazy = false,
	-- priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe", -- latte, frappe, macchiato, mocha
			no_italic = true,

			custom_highlights = function(colors)
				return {
					["@variable.parameter"] = { fg = colors.none },
				}
			end,
		})

		-- vim.cmd.colorscheme("catppuccin-frappe")
		-- vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
