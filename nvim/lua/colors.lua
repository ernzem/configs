-- DATA: https://github.com/neovim/neovim/pull/26334
local set_hl = vim.api.nvim_set_hl
local get_hl = vim.api.nvim_get_hl

-- change background color for default theme
local function change_colors(changes)
	for key, defaults in pairs(vim.api.nvim_get_hl(0, {})) do
		if changes[defaults["fg"]] ~= nil then
			set_hl(0, key, { fg = changes[defaults["fg"]], bg = defaults["bg"] })
		end

		if changes[defaults["bg"]] ~= nil then
			set_hl(0, key, { bg = changes[defaults["bg"]], fg = defaults["fg"] })
		end
	end
end

local function apply_light_changes()
	-- NvimLightGrey1 = "" or 12895949
	-- NvimLightGrey3 = "#2c2e33"
	-- local DarkYellow = "#756200"
	-- local background_color = "#E6E6E6"
	-- local background_color = "#E1E1E1"

    local background_color = "#F6F6F6"
	local cursorLineNrBg = "#DDDDDD"
	local ColorColumn = "#DDDDDD"
	local DarkYellow = "#754a00"
	local blue = "#284bbd"
	local green = "#30670f"
	local selection = "#D1D1D1"

	-- TODO: optimize replacing get with hardcoded values
	local status_ln = get_hl(0, { name = "StatuslineNC" })
	local StatementHi = get_hl(0, { name = "Statement" })

	change_colors({
		[get_hl(0, { name = "Function" }).fg] = blue,
		[get_hl(0, { name = "String" }).fg] = green,
	})

	set_hl(0, "Normal", { bg = background_color, fg = "#000000" })
	set_hl(0, "ColorColumn", { bg = "#F5F5F5" })
	set_hl(0, "Statusline", { bg = cursorLineNrBg, fg = status_ln.fg })
	set_hl(0, "StatuslineNC", { bg = cursorLineNrBg })
	set_hl(0, "WinBar", { bg = background_color, bold = true })
	set_hl(0, "WinbarNC", { bg = background_color })
	set_hl(0, "Special", { fg = StatementHi.fg })
	set_hl(0, "ColorColumn", { bg = ColorColumn })
	set_hl(0, "Special", { fg = StatementHi.fg })
	set_hl(0, "Cursorline", { bg = background_color })
	set_hl(0, "CursorlineNr", { fg = DarkYellow, bold = true })
	set_hl(0, "Visual", { bg = selection })
	set_hl(0, "MatchParen", { bg = selection })
	set_hl(0, "NormalFloat", { bg = background_color })

	set_hl(0, "Identifier", {})
	set_hl(0, "@variable", {})
	set_hl(0, "@variable.member", {})
	set_hl(0, "variable", {})
	set_hl(0, "variable.member", {})
end

local function apply_dark_changes()
	local TitleHi = get_hl(0, { name = "Title" })
	local NormalHi = get_hl(0, { name = "Normal" })
	local hl_comment = vim.api.nvim_get_hl(0, { name = "Comment" })
	local StatementHi = get_hl(0, { name = "Statement" })
	local DarkYellow = "#F0CA66"

	change_colors({
		[get_hl(0, { name = "Function" }).fg] = DarkYellow,
	})

	-- set_hl(0, "Normal", { bg = "#252525", fg = NormalHi.fg })
	set_hl(0, "WinBar", { bg = NormalHi.bg, fg = TitleHi.fg, bold = false })
	set_hl(0, "WinBarNC", { bg = NormalHi.bg })

	set_hl(0, "Cursorline", { bg = NormalHi.bg })
	set_hl(0, "CursorlineNr", { bg = "#2c2e33", bold = true })

	set_hl(0, "String", { fg = "#8CB648" })
	set_hl(0, "Special", { fg = StatementHi.fg })
	set_hl(0, "Statusline", { bg = NormalHi.bg, fg = hl_comment.fg })
	-- set_hl(0, "Statusline", { bg = NormalHi.bg })
	set_hl(0, "ColorColumn", { bg = "#7f7e77" })
end

local function fix_default_colorscheme()
	if vim.o.background == "light" then
		apply_light_changes()
	else
		apply_dark_changes()
	end
end

local augroup = vim.api.nvim_create_augroup
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = augroup("auto-reload-default-theme", { clear = true }),
	pattern = "*colors.lua",
	callback = function()
		vim.cmd("so %")
	end,
})

-- Apply changes every time when switching to this theme.
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup("apply-default-theme-changes", { clear = true }),
	pattern = "default",
	callback = fix_default_colorscheme,
})

-- vim.cmd("set bg=light")
vim.cmd("set bg=dark")
vim.cmd("colorscheme default")
fix_default_colorscheme()
