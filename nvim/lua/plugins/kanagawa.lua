return {
    'rebelot/kanagawa.nvim',
    lazy = true,
    config = function()
        require('kanagawa').setup({
            terminalColors = true,
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
