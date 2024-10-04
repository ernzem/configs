return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    event = "VeryLazy",
    config = function()
        require("onedark").setup({
            style = "warmer",
            toggle_style_key = "<leader>cs",
            toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
            diagnostics = { darker = false },
            highlights = {
                FoldColumn = { fg = "$grey", bg = "$bg0" },
                GitSignsChange = { fg = "$yellow" },
                GitSignsChangeNr = { fg = "$yellow" },
                GitSignsChangeLn = { fg = "$yellow" },
                GitSignsStagedChange = { fg = "$orange" },
                GitSignsStagedChangeLn = { fg = "$orange" },
                GitSignsStagedChangeNr = { fg = "$orange" },
                GitSignsStagedChangedelete = { fg = "$orange" },
                GitSignsStagedChangedeleteLn = { fg = "$orange" },
                GitSignsStagedChangedeleteNr = { fg = "$orange" },
                ["@string.escape"] = { fg = "$orange" },
            },
        })

        -- Disable highlights
        vim.api.nvim_set_hl(0, "@variable.parameter", {})
        vim.api.nvim_set_hl(0, "TelescopeBorder", {})
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {})
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", {})
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {})

        vim.cmd("colorscheme onedark")
    end,
}
