return {
	"https://github.com/nat-418/boole.nvim",
	lazy = true,
	cmd = "Boole",
	keys = {
		{ mode = { "n", "i" }, "<C-a>", "<cmd>Boole increment<cr>", desc = "Increment" },
		{ mode = { "n", "i" }, "<C-x>", "<cmd>Boole decrement<cr>", desc = "decrement" },
	},
	opts = {
		mappings = {
			increment = "<C-a>",
			decrement = "<C-x>",
		},

		-- Case insensitive toggle list
		allow_caps_additions = {
			{ "enable", "disable" },
		},

		-- Case sensitive toggle list
		-- additions = {
		-- {},
		--},
	},
}
