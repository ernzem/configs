return {
    "catppuccin/nvim",
    name = "catppuccin",
    -- priority = 1000,
    event = "VeryLazy",
    config = function()
        require("catppuccin").setup({
            color_overrides = {
                latte = {
                    base = "#f0f0f0",
                },
                mocha = {
                    -- Attempt to apply onedark colors
                    -- base = "#232326",
                    -- blue = "#57a5e5",
                    -- crust = "#37383d",
                    -- green = "#8fb573",
                    -- lavender = "#a7aab0",
                    -- mantle = "#2c2d31",
                    -- mauve = "#bb70d2",
                    -- overlay0 = "#5a5b5e",
                    -- pink = "#c27fd7",
                    -- red = "#de5d68",
                    -- peach = "#cc9057",
                    -- surface1 = "#5a5b5e",
                    -- yellow = "#dbb671",
                    -- teal = "#c49060",
                    -- text = "#a7aab0",

                    -- Org colors that haven't been changed
                    -- overlay1 = "#7f849c",
                    -- overlay2 = "#9399b2",
                    -- maroon = "#eba0ac",
                    -- flamingo = "#f2cdcd", cant find!!
                    -- rosewater = "#f5e0dc",
                    -- sapphire = "#74c7ec",
                    -- sky = "#89dceb",
                    -- subtext0 = "#a6adc8",
                    -- subtext1 = "#bac2de",
                    -- surface0 = "#313244",
                    -- surface2 = "#585b70", cant find
                },
            },
        })

        -- vim.cmd("colorscheme catppuccin-macchiato")
    end,
}
