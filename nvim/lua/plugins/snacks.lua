local h_layout = {
	preset = "default",
	layout = {
		box = "horizontal",
		height = 0.95,
		width = 0.95,
		{
			box = "vertical",
			border = "rounded",
			title = "{title} {live} {flags}",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
		},
		{ win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
	},
}

local dock = {
	preview = false,
	layout = {
		backdrop = false,
		row = 1,
		width = 0.4,
		min_width = 80,
		height = 0.3,
		border = "none",
		box = "vertical",
		{ win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
		{ win = "list", border = "rounded" },
		{ win = "preview", title = "{preview}", border = "rounded" },
	},
}

return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		picker = {
			enabled = true,
			sources = {
				explorer = {
					diagnostics = false,
					diagnostics_open = false,
					git_status = false,
					git_status_open = false,
					git_untracked = false,
				},
			},
		},
	},
	keys = {
		{
			"<leader>b",
			function()
				Snacks.picker.buffers({ layout = dock })
			end,
			desc = "Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep({ layout = h_layout })
			end,
			desc = "Grep",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help({ layout = h_layout })
			end,
			desc = "Search in help files",
		},
		{
			"<leader>f",
			function()
				Snacks.picker.files({ layout = dock })
			end,
			desc = "Find Files",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>SS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
	},
}
