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

-- vim.cmd("colorscheme kanagawa-wave")

vim.opt.background = "light"
vim.cmd("colorscheme github_light_default")
