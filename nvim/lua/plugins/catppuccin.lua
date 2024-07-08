return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            color_overrides = {
                latte = {
                    base = "#f0f0f0",
                },
            },
        })

        -- vim.cmd("colorscheme catppuccin-macchiato")
    end,
}
