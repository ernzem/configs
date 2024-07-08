-- default theme definition: https://github.com/neovim/neovim/blob/master/src/nvim/highlight_group.c
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
        local background_color = "#F0F0F0"
        -- local DarkYellow = "#5D2B0A"
        -- local DarkYellow = "#6f5013"
        -- local DarkYellow = "#73510d"
        local DarkYellow = "#754a00"

        set_hl(0, "ColorColumn", { bg = "#F5F5F5" })
        set_hl(0, "WinBar", { bg = background_color, fg = TitleHi.fg, bold = true })
        set_hl(0, "WinbarNC", { bg = background_color })
        set_hl(0, "Statusline", { bg = background_color, fg = status_ln.fg, bold = true })
        set_hl(0, "StatuslineNC", { bg = background_color })
        set_hl(0, "Cursorline", { bg = "#F9F9F9" })
        set_hl(0, "CursorlineNr", { bold = true })
        set_hl(0, "Special", { fg = StatementHi.fg })

        change_colors({
            [get_hl(0, { name = "Function" }).fg] = DarkYellow,
            [get_hl(0, { name = "Normal" }).bg] = background_color,
        })
    else
        local DarkYellow = "#F0CA66"

        set_hl(0, "WinBar", { bg = NormalHi.bg, fg = TitleHi.fg, bold = true })
        set_hl(0, "WinBarNC", { bg = NormalHi.bg })
        set_hl(0, "Statusline", { bg = NormalHi.bg, fg = NormalHi.fg })
        -- set_hl(0, "StatuslineNC", { bg = NormalHi.bg })
        set_hl(0, "ColorColumn", { bg = "#7f7e77" })
        -- set_hl(0, "Cursorline", { bg = NormalHi.bg, })
        set_hl(0, "Special", { fg = StatementHi.fg })
        set_hl(0, "String", { fg = "#8CB648" })

        change_colors({
            [get_hl(0, { name = "Function" }).fg] = DarkYellow,
        })
    end
end

-- Apply changes every time when switching to this theme.
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "default",
    callback = fix_default_colorscheme,
})

vim.cmd("colorscheme default")
