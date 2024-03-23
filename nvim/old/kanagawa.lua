return {
    'rebelot/kanagawa.nvim',
    -- event = "VeryLazy",
    config = function()
        require('kanagawa').setup({
            terminalColors = true,
            dimInactive = false,
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            }
        })
    end,
}
