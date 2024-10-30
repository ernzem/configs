local function workspace_dir()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		local github_light = require("lualine.themes.wombat")

		-- Change the background of lualine_c section for normal mode
		github_light.normal.c.bg = "#C9C9C9"
		github_light.normal.c.fg = "#000000"
		github_light.normal.b.bg = "#B4B4B4"
		github_light.normal.b.fg = "#000000"

		require("lualine").setup({
			options = {
				icons_enabled = false,
				theme = "auto",
				-- theme = github_light,
				component_separators = "|",
				section_separators = "",
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = false,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "  ".. "branch", "diff" },
				-- lualine_c = { workspace_dir, { 'filename', path = 1, shorting_target = 80, } },
				lualine_c = { workspace_dir },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
