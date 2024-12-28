return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	-- event = "VeryLazy",
	config = function()
		require("onedark").setup({
			style = "warmer",
			toggle_style_key = "<leader>cs",
			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
			diagnostics = { darker = false },
			highlights = {
				CursorLine = { bg = "$bg0" },
				CursorLineNr = { bg = "$bg1" },
				FoldColumn = { fg = "$grey", bg = "$bg0" },
				GitSignsChange = { fg = "$yellow" },
				GitSignsChangeNr = { fg = "$yellow" },
				GitSignsChangeLn = { fg = "$yellow" },
				GitSignsStagedChange = { fg = "$orange" },
				GitSignsStagedChangeLn = { fg = "$orange" },
				GitSignsStagedChangeNr = { fg = "$orange" },
				GitSignsStagedChangedelete = { fg = "$orange" },
				GitSignsStagedChangedeleteLn = { fg = "$orange" },
				GitSignsStagedChangedeleteNr = { fg = "$orange" },
				["@string.escape"] = { fg = "$orange" },
			},
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "onedark",
			callback = function()
				-- Disable highlights
				-- if vim.g.onedark_config.style == "light" then
				-- vim.api.nvim_set_hl(0, "Normal", { bg = "#f2f2f2" })
				-- end
				vim.api.nvim_set_hl(0, "@variable.parameter", {})
				vim.api.nvim_set_hl(0, "TelescopeBorder", {})
				vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {})
				vim.api.nvim_set_hl(0, "TelescopePromptBorder", {})
				vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {})
				vim.api.nvim_set_hl(0, "MsgArea", { bold = true })
			end,
		})

		vim.cmd("colorscheme onedark")
	end,
}
