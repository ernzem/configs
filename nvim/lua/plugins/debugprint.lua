-- https://github.com/andrewferrier/debugprint.nvim
return {
	"andrewferrier/debugprint.nvim",
	-- dependencies = {
	-- "echasnovski/mini.nvim",         -- Optional: Needed for line highlighting (full mini.nvim plugin)
	-- "echasnovski/mini.hipatterns",   -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)
	-- "ibhagwan/fzf-lua",              -- Optional: If you want to use the `:Debugprint search` command with fzf-lua
	-- "nvim-telescope/telescope.nvim", -- Optional: If you want to use the `:Debugprint search` command with telescope.nvim
	-- "folke/snacks.nvim",             -- Optional: If you want to use the `:Debugprint search` command with snacks.nvim
	-- },
	lazy = false, -- Required to make line highlighting work before debugprint is first used
	version = "*", -- Remove if you DON'T want to use the stable version
	opts = {
		keymaps = {
			normal = {
				toggle_comment_debug_prints = "g?c",
				delete_debug_prints = "g?d",
			}
		},
		-- … Other options
	},
}
