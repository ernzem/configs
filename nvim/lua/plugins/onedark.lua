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

				--MiniPick
				MiniPickMatchRanges = { fg = "$yellow" },
			},
		})

		-- * `MiniPickBorder` - window border.
		-- * `MiniPickBorderBusy` - window border while picker is busy processing.
		-- * `MiniPickBorderText` - non-prompt on border.
		-- * `MiniPickCursor` - cursor during active picker (hidden by default).
		-- * `MiniPickIconDirectory` - default icon for directory.
		-- * `MiniPickIconFile` - default icon for file.
		-- * `MiniPickHeader` - headers in info buffer and previews.
		-- * `MiniPickMatchCurrent` - current matched item.
		-- * `MiniPickMatchMarked` - marked matched items.
		-- * `MiniPickMatchRanges` - ranges matching query elements.
		-- * `MiniPickNormal` - basic foreground/background highlighting.
		-- * `MiniPickPreviewLine` - target line in preview.
		-- * `MiniPickPreviewRegion` - target region in preview.
		-- * `MiniPickPrompt` - prompt.
		--
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("onedar-theme-changes", { clear = true }),
			pattern = "onedark",
			callback = function()
				-- Disable highlights
				-- if vim.g.onedark_config.style == "light" then
				-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "#f9f9f9" })
				-- end

				-- Disable lua variable highlight
				vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", {})
				vim.api.nvim_set_hl(0, "@lsp.type.parameter", {})
				vim.api.nvim_set_hl(0, "@variable", {})
				vim.api.nvim_set_hl(0, "@variable.builtin", {})

				-- Others
				vim.api.nvim_set_hl(0, "@variable.parameter", {})
				-- vim.api.nvim_set_hl(0, "TelescopeBorder", {})
				-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {})
				-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", {})
				-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {})
			end,
		})

		vim.cmd("colorscheme onedark")
	end,
}
