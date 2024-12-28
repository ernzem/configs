local M = {}

local save = " %m"
local right_side = "%="

local hl_path = "WinBarPath"
local hl_file = "WinBarFile"
local hl_symbols = "WinBarSymbols"
local hl_file_icon = "WinBarBufFileIcon"

local hl_error = "WinBarDiagnosticSignError"
local hl_warn = "WinBarDiagnosticSignWarn"
local hl_hint = "WinBarDiagnosticSignHint"
local hl_info = "WinBarDiagnosticSignInfo"

local opts = {
	file_icon_default = "",
	folder_icon = "",
	seperator = "⏵",
	editor_state = "●",
}

local utils = require("utils")

M.file_path = function()
	local value = ""

	local file_path = vim.fn.expand("%:~:.:h")
	local filename = vim.fn.expand("%:t")
	local file_type = vim.fn.expand("%:e")

	file_path = file_path:gsub("^%.", "")
	file_path = file_path:gsub("^%/", "")

	if utils.isempty(filename) then
		return value
	end

	if utils.isempty(file_type) then
		file_type = ""
	end

	local icon, icon_cl = utils.file_icon(filename, file_type)
	if icon ~= "" then
		vim.api.nvim_set_hl(0, hl_file_icon, { fg = icon_cl, bg = M.winbar_bg, bold = true })
	else
        icon = opts.file_icon_default
		vim.api.nvim_set_hl(0, hl_file_icon, { fg = M.winbar_fg, bg = M.winbar_bg, bold = true })
	end

	icon = "%#" .. hl_file_icon .. "#" .. icon .. "%*"

	value = "%#" .. hl_path .. "#" .. " "
	local file_path_list = {}
	local _ = string.gsub(file_path, "[^/]+", function(w)
		table.insert(file_path_list, w)
	end)

	local path_length = #file_path_list
	if path_length > 0 then
		value = value .. opts.folder_icon .. " "
	end

	for i = 1, path_length do
		local sep = opts.seperator
		if i ~= path_length then
			sep = sep .. " " .. opts.folder_icon
		end

		value = value .. "%#" .. hl_path .. "#" .. file_path_list[i] .. " " .. sep .. " %*"
	end

	return value .. icon .. "%#" .. hl_file .. "#" .. " " .. filename
end

function M.lsp_info()
	local count = {}
	local levels = {
		errors = vim.diagnostic.severity.ERROR,
		warnings = vim.diagnostic.severity.WARN,
		info = vim.diagnostic.severity.INFO,
		hints = vim.diagnostic.severity.HINT,
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#" .. hl_error .. "#" .. utils.diagn_symbols.error .. " " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#" .. hl_warn .. "#" .. utils.diagn_symbols.warn .. " " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#" .. hl_hint .. "#" .. utils.diagn_symbols.hint .. " " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#" .. hl_info .. "#" .. utils.diagn_symbols.info .. " " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. " "
end

local function get_winbar()
	return M.file_path() .. save .. right_side .. M.lsp_info()
end

function M.create()
	if utils.is_ui_filetype(vim.bo.filetype) then
		return
	end

	vim.wo.winbar = get_winbar()
end

function M.update()
	if utils.is_ui_filetype(vim.bo.filetype) or utils.is_insert_mode() then
		return
	end

	-- Attach winbar to all windows/splits that have the same buffer
	for _, id in pairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(id) == vim.api.nvim_get_current_buf() then
			vim.wo[id].winbar = get_winbar()
		end
	end
end

local winbar_autocmd_group = vim.api.nvim_create_augroup("winbar", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = winbar_autocmd_group,
	pattern = "*.*",
	callback = M.create,
})

vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
	group = winbar_autocmd_group,
	pattern = "*.*",
	callback = M.update,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	group = winbar_autocmd_group,
	pattern = "*",
	callback = function()
		M.winbar_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
		M.winbar_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg

		local hl_msg_area = vim.api.nvim_get_hl(0, { name = "Comment" })

		vim.api.nvim_set_hl(0, hl_file, { bg = M.winbar_bg, bold = false })
		vim.api.nvim_set_hl(0, hl_path, { fg = hl_msg_area.fg, bg = M.winbar_bg })
		vim.api.nvim_set_hl(0, hl_symbols, { bg = M.winbar_bg })

		local hl_org_lsp_error = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
		local hl_org_lsp_warn = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
		local hl_org_lsp_hint = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })
		local hl_org_lsp_info = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })

		vim.api.nvim_set_hl(0, hl_error, { fg = hl_org_lsp_error.fg, bg = M.winbar_bg })
		vim.api.nvim_set_hl(0, hl_warn, { fg = hl_org_lsp_warn.fg, bg = M.winbar_bg })
		vim.api.nvim_set_hl(0, hl_hint, { fg = hl_org_lsp_hint.fg, bg = M.winbar_bg })
		vim.api.nvim_set_hl(0, hl_info, { fg = hl_org_lsp_info.fg, bg = M.winbar_bg })

		M.update()
	end,
})

return M
