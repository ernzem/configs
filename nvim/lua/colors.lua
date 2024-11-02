-- default theme definition: https://github.com/neovim/neovim/blob/master/src/nvim/highlight_group.c
-- DATA: https://github.com/neovim/neovim/pull/26334

-- Dark palette:
-- grey3   = "#2c2e33" -- CursorLine

-- Light palette:
--
local set_hl = vim.api.nvim_set_hl
local get_hl = vim.api.nvim_get_hl

-- change background color for default theme
local function change_colors(changes)
	for key, value in pairs(vim.api.nvim_get_hl(0, {})) do
		if changes[value["fg"]] ~= nil then
			set_hl(0, key, { fg = changes[value["fg"]] })
		end

		if changes[value["bg"]] ~= nil then
			set_hl(0, key, { bg = changes[value["bg"]] })
		end
	end
end

local function fix_default_colorscheme()
    local NormalHi = get_hl(0, { name = "Normal" })
    local TitleHi = get_hl(0, { name = "Title" })
    local StatementHi = get_hl(0, { name = "Statement" })
    local status_ln = get_hl(0, { name = "StatuslineNC" })

	if vim.o.background == "light" then
		local background_color = "#F2F2F2"
        local cursorLine = "#F9F9F9"
		local DarkYellow = "#756200"
        -- local DarkYellow = "#754a00"

        set_hl(0, "ColorColumn", { bg = "#F5F5F5" })
        set_hl(0, "WinBar", { bg = background_color, bold = true })
        set_hl(0, "WinbarNC", { bg = background_color })
        set_hl(0, "Statusline", { bg = background_color, fg = status_ln.fg, bold = true })
        set_hl(0, "StatuslineNC", { bg = background_color })
        set_hl(0, "Cursorline", { bg = "#F9F9F9" })
        set_hl(0, "CursorlineNr", { bold = true })
        set_hl(0, "Special", { fg = StatementHi.fg })

		set_hl(0, "ColorColumn", { bg = "#F5F5F5" })
		set_hl(0, "Cursorline", { bg = cursorLine })
		set_hl(0, "CursorlineNr", { bg = cursorLine, bold = true })
		set_hl(0, "Special", { fg = StatementHi.fg })

		change_colors({
			[get_hl(0, { name = "Function" }).fg] = DarkYellow,
			[get_hl(0, { name = "Normal" }).bg] = background_color,
		})
	else
		local DarkYellow = "#F0CA66"
        set_hl(0, "WinBar", { bg = NormalHi.bg, fg = TitleHi.fg, bold = true })
        set_hl(0, "WinBarNC", { bg = NormalHi.bg })

        set_hl(0, "Cursorline", { bg ="#14161b" })
        set_hl(0, "CursorlineNr", { bg = "#2c2e33" })

        set_hl(0, "String", { fg = "#8CB648" })
        set_hl(0, "Special", { fg = StatementHi.fg })
        set_hl(0, "Statusline", { bg = NormalHi.bg, fg = NormalHi.fg })
        set_hl(0, "ColorColumn", { bg = "#7f7e77" })

		change_colors({
			[get_hl(0, { name = "Function" }).fg] = DarkYellow,
		})
	end
end

local augroup = vim.api.nvim_create_augroup
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = augroup("auto-reload-default-theme", { clear = true }),
	pattern = "*colors.lua",
	callback = function()
		vim.cmd("so lua/colors.lua")
	end,
})

-- Apply changes every time when switching to this theme.
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup("apply-default-theme-changes", { clear = true }),
	pattern = "default",
	callback = fix_default_colorscheme
})

vim.cmd("colorscheme default")
fix_default_colorscheme()
