return {
    "p00f/alabaster.nvim",
    -- lazy = false,
    -- priority = 1000,
    event = "VeryLazy",
    config = function ()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("alabaster-theme-changes", { clear = true }),
			pattern = "alabaster",
			callback = function()
				vim.api.nvim_set_hl(0, "Comment", {fg = "#707070"})
				vim.api.nvim_set_hl(0, "CursorLine", {bg = "#EEEEEE"})
				-- vim.api.nvim_set_hl(0, "CursorLineNr", {bg = "#DDDDDD"})
			end,
		})

		-- vim.cmd("colorscheme alabaster")
    end
}
