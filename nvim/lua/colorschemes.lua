local hi = vim.api.nvim_set_hl

local function disable_highlights(hls)
    for _, hl in pairs(hls) do
        vim.api.nvim_set_hl(0, hl, {})
    end
end

local function onedark_changes()
    -- Based on "Warmer" style off: https://github.com/navarasu/onedark.nvim
    -- local warmer = {
    -- 	black = "#101012",
    -- 	bg0 = "#232326",
    -- 	bg1 = "#2c2d31",
    -- 	bg2 = "#35363b",
    -- 	bg3 = "#37383d",
    -- 	bg_d = "#1b1c1e",
    -- 	bg_blue = "#68aee8",
    -- 	bg_yellow = "#e2c792",
    -- 	fg = "#a7aab0",
    -- 	purple = "#bb70d2",
    -- 	green = "#8fb573",
    -- 	orange = "#c49060",
    -- 	blue = "#57a5e5",
    -- 	yellow = "#dbb671",
    -- 	cyan = "#51a8b3",
    -- 	red = "#de5d68",
    -- 	grey = "#5a5b5e",
    -- 	light_grey = "#818387",
    -- 	dark_cyan = "#2b5d63",
    -- 	dark_red = "#833b3b",
    -- 	dark_yellow = "#7c5c20",
    -- 	dark_purple = "#79428a",
    -- 	diff_add = "#282b26",
    -- 	diff_delete = "#2a2626",
    -- 	diff_change = "#1a2a37",
    -- 	diff_text = "#2c485f",
    -- }

    disable_highlights({
        "@variable.parameter",
        "TelescopeBorder",
        "TelescopePreviewBorder",
        "TelescopePromptBorder",
        "TelescopeResultsBorder",
    })

    -- Change highlight properties
    hi(0, "@string.escape", { fg = "#c49060" })
    hi(0, "FoldColumn", { fg = "#5a5b5e" })

    hi(0, "GitSignsChange", { fg = "#dbb671" })
    hi(0, "GitSignsChangeLn", { fg = "#dbb671" })
    hi(0, "GitSignsChangeNr", { fg = "#dbb671" })
    hi(0, "GitSignsStagedChange", { fg = "#c49060" })
    hi(0, "GitSignsStagedChangeLn", { fg = "#c49060" })
    hi(0, "GitSignsStagedChangeNr", { fg = "#c49060" })
    hi(0, "GitSignsStagedChangedelete", { fg = "#c49060" })
    hi(0, "GitSignsStagedChangedeleteLn", { fg = "#c49060" })
    hi(0, "GitSignsStagedChangedeleteNr", { fg = "#c49060" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "onedark",
    callback = onedark_changes,
})

vim.cmd("colorscheme onedark")
