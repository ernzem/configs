local utils = require("utils")

local function workspace_dir()
	return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function file_icon(filetype)
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok or not filetype then
        return ""
    end

    local icon, _ = icons.get_icon_by_filetype(filetype)
    if not icon then
        return ""
    end

    return icon
end

local function grapple_marks()
    local t = require("grapple").tags()
    if t == nil then
        return ""
    end

    local m = ""
    for i, v in ipairs(t) do
        if v.path == nil then
            goto continue
        end

        local filename = vim.fs.basename(v.path)
        local ic  = file_icon(vim.filetype.match({ filename = filename }))
        m = m  .. " " .. i .. ": " .. ic .. " " .. filename .. " "
        ::continue::
    end

    return m
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	opts = {
        options = {
				icons_enabled = true,
				theme = "auto",
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
					statusline = 10000000,
					tabline = 10000000,
					winbar = 10000000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {  "branch", workspace_dir},
				-- lualine_c = { { "filename", path = 1 }},
				lualine_c = { grapple_marks },
				lualine_x = { {
                    "diagnostics",
                    sources = { 'nvim_workspace_diagnostic' },
                    symbols = {
                        error = utils.diagn_symbols.error .. ' ',
                        warn = utils.diagn_symbols.warn .. ' ',
                        info = utils.diagn_symbols.info .. ' ',
                        hint = utils.diagn_symbols.hint .. ' '
                    }},
                    "filetype"
                },
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
		}
}
