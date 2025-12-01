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
	local background_color = "#FFFFFF"
	-- local background_color = "#F8F8F8"
	-- local background_color = "#F0F0F0"
	local cursorLineNrBg = "#F0F0F0"
	local ColorColumn = "#DDDDDD"
	-- local DarkYellow = "#664200"
	local DarkYellow = "#795E26"
	-- local cyan = "#004e75"
	local cyan = "#005c8a"
	-- local green = "#008000"
	local green = "#005900"
	local selection = "#EEEEDA"
	-- local blue = "#000ea3"
	local blue = "#000095"
	local grey = "#909090"
	local violet = "#74287b"
	-- local normal = "#202020"
	local normal = "#101010"
	-- local normal = "#171717"
	-- local normal = "#181818"
	local normal = "#000000"
	-- local normal = "#001080"

	local brown = "#8B4000"
	local black = "#000000"

	-- TODO: optimize replacing get with hardcoded values
	-- local status_ln = get_hl(0, { name = "StatuslineNC" })
	local StatementHi = get_hl(0, { name = "Statement" })
	local CommentHi = get_hl(0, { name = "Comment" })
	-- local IdentifierHi = get_hl(0, { name = "Identifier" })

	change_colors({
		[get_hl(0, { name = "Identifier" }).fg] = normal,
		-- [get_hl(0, { name = "Function" }).fg] = DarkYellow,
		[get_hl(0, { name = "String" }).fg] = green,
	})

	set_hl(0, "Normal", { bg = background_color, fg = normal })
	set_hl(0, "ColorColumn", { bg = "#F5F5F5" })
	set_hl(0, "Statusline", { bg = background_color, fg = CommentHi.fg })
	set_hl(0, "StatuslineNC", { bg = background_color })
	set_hl(0, "WinBar", { bg = background_color, fg = black })
	set_hl(0, "WinbarNC", { bg = background_color })
	set_hl(0, "ColorColumn", { bg = ColorColumn })
	set_hl(0, "Special", { fg = StatementHi.fg })
	set_hl(0, "Cursorline", { bg = background_color })
	set_hl(0, "CursorlineNr", { fg = violet, bold = true })
	set_hl(0, "Visual", { bg = selection })
	set_hl(0, "MatchParen", { bg = selection })
	set_hl(0, "NormalFloat", { bg = background_color })
	set_hl(0, "Comment", { fg = grey })
	set_hl(0, "Function", { fg = blue, bold = false })
	set_hl(0, "Keyword", { fg = violet, bold = true })
	-- set_hl(0, "Keyword", { fg = black, bold = true })
	set_hl(0, "type", { fg = cyan, bold = false })
	-- set_hl(0, "type", { fg = DarkYellow, bold = false })
	-- set_hl(0, "@variable.member", { fg = DarkYellow })
	set_hl(0, "@type.builtin", { link = "type" })

	set_hl(0, "@boolean", { fg = cyan, bold = false })
	set_hl(0, "@number", { fg = cyan, bold = false })
	set_hl(0, "@variable", { fg = normal })
	set_hl(0, "@constant", { fg = normal })
	set_hl(0, "@variable.builtin", { fg = violet, underline = false })
	set_hl(0, "@punctuation", { fg = normal, italic = false })
	set_hl(0, "@constructor", { link = "@punctuation" })
	set_hl(0, "@punctuation.bracket", { link = "@punctuation" })
	set_hl(0, "@punctuation.special", { link = "@punctuation" })
	set_hl(0, "operator", { link = "@punctuation" })
end

local function apply_dark_changes()
	-- https://github.com/spacelaxy/darkwaves/blob/main/themes/darkwaves-nebula.json/
	local TitleHi = get_hl(0, { name = "Title" })
	-- local NormalHi = get_hl(0, { name = "Normal" })
	local HLComment = get_hl(0, { name = "Comment" })
	local StatementHi = get_hl(0, { name = "Statement" })

	-- local background = "#191b1f"
	local background = "#181818"
	local normal = "#ABB2BF"
	local blue = "#61AFEF"
	local comment = "#5C6370"
	local DarkYellow = "#F0CA66"
	-- local DarkYellow = "#FFA500" -- ORANGE!
	local type = "#65bea7"
	local violet = "#C678DD"
	local cyan = "#56B6C2"

	local green = "#98C379"
	local brown = "#D19A66"

	local error = "#E06C75"
	local warning = "#E5C07B"
    local hint = "#FFFFFF"

	change_colors({
		[get_hl(0, { name = "Function" }).fg] = blue,
		[get_hl(0, { name = "Identifier" }).fg] = cyan,
	})

	set_hl(0, "Normal", { fg = normal, bg = background })
	set_hl(0, "NormalFloat", { bg = background })
	set_hl(0, "WinBar", { bg = normal, fg = TitleHi.fg, bold = false })
	set_hl(0, "WinBarNC", { bg = normal })

	set_hl(0, "Cursorline", { bg = background })
	set_hl(0, "CursorlineNr", { fg = brown, bold = false })

	set_hl(0, "String", { fg = green })
	set_hl(0, "Comment", { fg = comment, italic = true })
	set_hl(0, "Function", { fg = blue, bold = false })
	set_hl(0, "Special", { fg = StatementHi.fg })
	set_hl(0, "Statusline", { bg = background, fg = comment })
	-- set_hl(0, "ColorColumn", { bg = "#7f7e77" })

	set_hl(0, "@keyword", { fg = violet })
	-- set_hl(0, "@operator", { fg = keyword })
	-- set_hl(0, "@keyword.type", { fg = keyword })

	set_hl(0, "@type", { fg = type })
	set_hl(0, "@type.builtin", { fg = type })
	set_hl(0, "@type.definition", { fg = type })
	set_hl(0, "@boolean", { fg = brown, bold = false })
	set_hl(0, "@number", { fg = brown, bold = false })

	set_hl(0, "@variable", { fg = normal })
	set_hl(0, "@constant", { fg = normal })
	set_hl(0, "@variable.builtin", { fg = violet, underline = false })

	set_hl(0, "@punctuation", { fg = normal, italic = true })
	set_hl(0, "@constructor", { link = "@punctuation" })
	set_hl(0, "@punctuation.bracket", { link = "@punctuation" })
	set_hl(0, "@punctuation.special", { link = "@punctuation" })
	set_hl(0, "operator", { link = "@punctuation" })

	set_hl(0, "DiagnosticError", { fg = error })
	set_hl(0, "DiagnosticWarning", { fg = warning })
	set_hl(0, "DiagnosticHint", { fg = brown })
	set_hl(0, "DiagnosticOk", { fg = comment })
end

-- local function apply_dark_changes()
-- 	local TitleHi = get_hl(0, { name = "Title" })
-- 	local NormalHi = get_hl(0, { name = "Normal" })
-- 	local HLComment = get_hl(0, { name = "Comment" })
-- 	local StatementHi = get_hl(0, { name = "Statement" })
-- 	-- local DarkYellow = "#F0CA66"
-- 	local blue = "#6699ff"
-- 	-- local DarkYellow = "#FFA500" -- ORANGE!
-- 	local type = "#65bea7"
-- 	local violet = "#d87bf4"
-- 	local cyan = "#a6e3f2"
--
-- 	-- local green = "#8CB648"
-- 	-- local green = "#66b83d"
-- 	local green = "#70aa55"
--
-- 	local normal = "#d7d9e1"
-- 	local brown = "#c2925f"
--
-- 	-- local type = "#fd4096"
-- 	-- local type = "#69abff"
-- 	-- local type = "#c07530"
--
-- 	-- local keyword = "#cc9ffc"
-- 	-- local keyword = "#69abff"
-- 	-- local keyword = "#c586c0"
--
-- 	change_colors({
-- 		[get_hl(0, { name = "Function" }).fg] = blue,
-- 		[get_hl(0, { name = "Identifier" }).fg] = cyan,
-- 	})
--
-- 	set_hl(0, "Normal", { fg = NormalHi.fg })
-- 	set_hl(0, "WinBar", { bg = NormalHi.bg, fg = TitleHi.fg, bold = false })
-- 	set_hl(0, "WinBarNC", { bg = NormalHi.bg })
--
-- 	set_hl(0, "Cursorline", { bg = NormalHi.bg })
-- 	set_hl(0, "CursorlineNr", { bg = "#2c2e33", bold = false })
--
-- 	set_hl(0, "String", { fg = green })
-- 	set_hl(0, "Function", { fg = blue, bold = false })
-- 	set_hl(0, "Special", { fg = StatementHi.fg })
-- 	set_hl(0, "Statusline", { bg = NormalHi.bg, fg = HLComment.fg })
-- 	set_hl(0, "ColorColumn", { bg = "#7f7e77" })
--
-- 	set_hl(0, "@keyword", { fg = violet })
-- 	-- set_hl(0, "@operator", { fg = keyword })
-- 	-- set_hl(0, "@keyword.type", { fg = keyword })
--
-- 	set_hl(0, "@type", { fg = type })
-- 	set_hl(0, "@type.builtin", { fg = type })
-- 	set_hl(0, "@type.definition", { fg = type })
-- 	set_hl(0, "@boolean", { fg = brown, bold = false })
-- 	set_hl(0, "@number", { fg = brown, bold = false })
-- end

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
-- vim.cmd("set bg=dark")
vim.cmd("colorscheme default")
fix_default_colorscheme()
