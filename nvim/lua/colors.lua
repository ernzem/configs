-- DATA: https://github.com/neovim/neovim/pull/26334
-- https://github.com/neovim/neovim/blob/master/src/nvim/highlight_group.c

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
	local background_color = "#EEEEEE"
	local cursorLineNrBg = "#DDDDDD"
	local ColorColumn = "#DDDDDD"
	local DarkYellow = "#664200"
	local cyan = "#004e75"
	local green = "#005600"
	local selection = "#D1D1D1"
	local blue = "#153bb7"
	local github_violet = "#6614b3"
    -- local yellow = "#b58407"

	-- TODO: optimize replacing get with hardcoded values
	local status_ln = get_hl(0, { name = "StatuslineNC" })
	local StatementHi = get_hl(0, { name = "Statement" })
	-- local IdentifierHi = get_hl(0, { name = "Identifier" })

	change_colors({
		[get_hl(0, { name = "Identifier" }).fg] = cyan,
		-- [get_hl(0, { name = "Identifier" }).fg] = DarkYellow,
		[get_hl(0, { name = "Function" }).fg] = blue,
		[get_hl(0, { name = "String" }).fg] = green,
	})

	set_hl(0, "Normal", { bg = background_color, fg = "#333333" })
	set_hl(0, "ColorColumn", { bg = "#F5F5F5" })
	set_hl(0, "Statusline", { bg = cursorLineNrBg, fg = status_ln.fg })
	set_hl(0, "StatuslineNC", { bg = cursorLineNrBg })
	set_hl(0, "WinBar", { bg = background_color })
	set_hl(0, "WinbarNC", { bg = background_color })
	set_hl(0, "ColorColumn", { bg = ColorColumn })
	set_hl(0, "Special", { fg = StatementHi.fg })
	set_hl(0, "Cursorline", { bg = background_color })
	set_hl(0, "CursorlineNr", { fg = DarkYellow, bold = true })
	set_hl(0, "Visual", { bg = selection })
	set_hl(0, "MatchParen", { bg = selection })
	set_hl(0, "NormalFloat", { bg = background_color })
	-- set_hl(0, "Function", { fg = blue, bold=true })

	-- set_hl(0, "keyword", { fg = github_violet })
	-- set_hl(0, "Identifier", { fg = github_violet })
	-- set_hl(0, "type", { fg = github_violet })

	-- set_hl(0, "Identifier", { fg = DarkYellow })
	-- set_hl(0, "type", { fg = DarkYellow })

	set_hl(0, "type", { fg = cyan })
	-- set_hl(0, "@variable.member", { fg = DarkYellow })
	set_hl(0, "@boolean", { fg = github_violet })
	set_hl(0, "@number", { fg = github_violet })

	set_hl(0, "@variable", { fg = "#333333" })
	-- set_hl(0, "keyword", { fg = "#333333", bold = true })
	-- set_hl(0, "@variable", {})
	-- set_hl(0, "@variable.member", { fg = github_violet })
	-- set_hl(0, "variable", {})
	-- set_hl(0, "variable.member", {})
end

local function apply_dark_changes()
	local TitleHi = get_hl(0, { name = "Title" })
	local NormalHi = get_hl(0, { name = "Normal" })
	local HLComment = get_hl(0, { name = "Comment" })
	local StatementHi = get_hl(0, { name = "Statement" })
	local DarkYellow = "#F0CA66"

	-- local type = "#fd4096"
	-- local type = "#69abff"
	-- local type = "#c07530"
	local type = "#a6dbff"

	-- local keyword = "#cc9ffc"
	-- local keyword = "#69abff"
	-- local keyword = "#c586c0"

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
	set_hl(0, "Statusline", { bg = NormalHi.bg, fg = HLComment.fg })
	set_hl(0, "ColorColumn", { bg = "#7f7e77" })

	-- set_hl(0, "@keyword", { fg = keyword })
	-- set_hl(0, "@operator", { fg = keyword })
	-- set_hl(0, "@keyword.type", { fg = keyword })

	set_hl(0, "@type", { fg = type })
	set_hl(0, "@type.builtin", { fg = type })
	set_hl(0, "@type.definition", { fg = type })
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

vim.cmd("set bg=light")
-- vim.cmd("set bg=dark")
vim.cmd("colorscheme default")
fix_default_colorscheme()
