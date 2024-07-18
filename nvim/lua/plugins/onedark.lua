local default_style = "warmer"

return {
    "navarasu/onedark.nvim",
    -- lazy = false,
    -- priority = 1000,
    event = "VeryLazy",
    init = function()
        vim.g.onedark_config = {
            style = default_style,
        }
    end,
    config = function()
        require("onedark").setup({
            style = default_style,

            toggle_style_key = "<leader>cs",
            toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
            -- colors = {
            --     background = require("onedark.colors").bg0,
            -- },
            -- highlights = {
            --     FoldColumn = { bg = "$background" },
            --     -- FoldColumn = { bg = "#000000" },
            -- },
        })
    end,
}
