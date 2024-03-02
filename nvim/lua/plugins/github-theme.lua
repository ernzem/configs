return {
    'projekt0n/github-nvim-theme',
    event = "VeryLazy",
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require('github-theme').setup({
            options = {
                terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                dim_inactive = true     -- Non focused panes set to alternative background
            },
            --     palettes = {
            --         github_light_high_contrast = {
            --             bg0 = '#eeeeee', -- Alt backgrounds (floats, statusline, ...)
            --         },
            --     },
            --     specs = {
            --         github_light_high_contrast = {
            --             inactive = 'bg0'
            --         }
            --     },
            --     groups = {
            --         all = {
            --             NormalNC = { fg = 'fg1', bg = 'inactive' }, -- Non-current windows
            --         },
            --     }
        })
    end,
}
