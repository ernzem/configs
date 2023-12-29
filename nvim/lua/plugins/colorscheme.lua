-- vim.cmd.colorscheme 'github_light_high_contrast'
require('kanagawa').setup({
    terminalColors = false,
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

vim.cmd("colorscheme kanagawa-wave")
