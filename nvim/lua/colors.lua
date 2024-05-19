-- change background color for default theme
local function override_colors(color)
    local cyan = vim.api.nvim_get_hl(0, { name = "Function" }).fg

    for key, value in pairs(vim.api.nvim_get_hl(0, {})) do
        if value["fg"] ~= nil and value["fg"] == cyan then
            vim.api.nvim_set_hl(0, key, { fg = color })
        end
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "default",
    callback = function()
        NormalHi = vim.api.nvim_get_hl(0, { name = "Normal" })
        TitleHi = vim.api.nvim_get_hl(0, { name = "Title" })
        StatementHi = vim.api.nvim_get_hl(0, { name = "Statement" })

        if vim.o.background == "light" then
            local background_color = "#FFFFFF"
            local DarkYellow = "#5D2B0A"

            vim.api.nvim_set_hl(0, "Normal", { bg = background_color })
            vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#F5F5F5" })
            -- vim.api.nvim_set_hl(0, "Cursorline", { bg = background_color })
            vim.api.nvim_set_hl(0, "WinBar", { bg = background_color, fg = TitleHi.fg, bold = true })
            vim.api.nvim_set_hl(0, "WinbarNC", { bg = background_color })
            -- vim.api.nvim_set_hl(0, "Statusline", { bg = background_color, fg = NormalHi.fg })
            -- vim.api.nvim_set_hl(0, "StatuslineNC", { bg = background_color })
            vim.api.nvim_set_hl(0, "Special", { fg = StatementHi.fg })

            override_colors(DarkYellow)
        else
            local DarkYellow = "#F0CA66"

            vim.api.nvim_set_hl(0, "WinBar", { bg = NormalHi.bg, fg = TitleHi.fg, bold = true })
            vim.api.nvim_set_hl(0, "WinBarNC", { bg = NormalHi.bg })
            vim.api.nvim_set_hl(0, "Statusline", { bg = NormalHi.bg, fg = NormalHi.fg })
            -- vim.api.nvim_set_hl(0, "StatuslineNC", { bg = NormalHi.bg })
            vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1E2025" })
            -- vim.api.nvim_set_hl(0, "Cursorline", { bg = NormalHi.bg, })
            vim.api.nvim_set_hl(0, "Special", { fg = StatementHi.fg })
            vim.api.nvim_set_hl(0, "String", { fg = "#8CB648" })

            override_colors(DarkYellow)
        end
    end,
})

vim.cmd("colorscheme default")
