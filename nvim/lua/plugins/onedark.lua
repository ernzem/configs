return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	-- event = "VeryLazy",
	config = function()
		require("onedark").setup({
			style = "light",
			toggle_style_key = "<leader>cs",
			-- toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
			toggle_style_list = { "warm", "warmer", "light" },
			diagnostics = { darker = false },
			highlights = {
				CursorLine = { bg = "$bg0" },
				CursorLineNr = { bg = "$bg2", bold = true },
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

				SnacksPicker = { bg = "$bg0" },
				SnacksPickerListCursorline = { bg = "$bg1" },
				SnacksPickerBorder = { bg = "$bg0", fg = "$fg", bold = true, default = true },

				NvimTreeNormal = { bg = "$bg0" },
				NvimTreeVerticalSplit = { bg = "$bg0" },
                NvimTreeEndOfBuffer = { bg = "$bg0"}
			},
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("onedark-theme-changes", { clear = true }),
			pattern = "onedark",
			callback = function()
				-- Disable lua variable highlight
				vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", {})
				vim.api.nvim_set_hl(0, "@lsp.type.parameter", {})
				vim.api.nvim_set_hl(0, "@variable", {})
				vim.api.nvim_set_hl(0, "@variable.builtin", {})

				-- Others
				vim.api.nvim_set_hl(0, "@variable.parameter", {})
			end,
		})

		vim.cmd("colorscheme onedark")
	end,
}
