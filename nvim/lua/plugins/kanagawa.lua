return {
    "rebelot/kanagawa.nvim",
    event = "VeryLazy",
    config = function()
        require("kanagawa").setup({
            -- Recompile with every change with :KanagawaCompile
            compile = true, -- enable compiling the colorscheme
            terminalColors = true,
            dimInactive = true,
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
            overrides = function(colors)
                -- local theme = colors.theme
                return {
                    -- StatusLine = { bg = theme.ui.bg },
                    -- StatusLineNC = { bg = theme.ui.bg },
                    MsgArea = { bold = true },
                }
            end,
        })
    end,
}
