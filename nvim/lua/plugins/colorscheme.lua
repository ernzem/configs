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
require('github-theme').setup({
    options = {
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = true     -- Non focused panes set to alternative background
    },
    palettes = {
        github_light_high_contrast = {
            bg0 = '#eeeeee', -- Alt backgrounds (floats, statusline, ...)
        },
    },
    specs = {
        github_light_high_contrast = {
            inactive = 'bg0'
        }
    },
    groups = {
        all = {
            NormalNC = { fg = 'fg1', bg = 'inactive' }, -- Non-current windows
        },
    }
})

vim.cmd("colorscheme github_light_high_contrast")
