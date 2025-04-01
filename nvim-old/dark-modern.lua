return {
	"rockyzhang24/arctic.nvim",
	branch = "v2",
	dependencies = { "rktjmp/lush.nvim" },
	config = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("arctic-theme-changes", { clear = true }),
			pattern = "arctic",
			callback = function()
				vim.api.nvim_set_hl(0, "Comment", { fg = "#808080" })
				vim.api.nvim_set_hl(0, "String", { fg = "#70aa55" })
				vim.api.nvim_set_hl(0, "Constant", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "@constant", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "@constant.builtin", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "Identifier", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "variable", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "variable", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "@variable", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "@variable.member", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "@variable.parameter.builtin", { fg = "#BFBFBF" })
				vim.api.nvim_set_hl(0, "@boolean", { fg = "#acc4a0" })
				-- vim.api.nvim_set_hl(0, "Comment", {fg = "#808080"})
				-- vim.api.nvim_set_hl(0, "CursorLine", {bg = "#EEEEEE"})
				-- vim.api.nvim_set_hl(0, "CursorLineNr", {bg = "#DDDDDD"})
			end,
		})

		-- vim.cmd("colorscheme arctic")
	end,
}
