local custom_wombat = require('lualine.themes.wombat')

-- Change the background of lualine_c section for normal mode
custom_wombat.normal.c.bg = '#C9C9C9'
custom_wombat.normal.c.fg = '#000000'
custom_wombat.normal.b.bg = '#B4B4B4'
custom_wombat.normal.b.fg = '#000000'

require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = custom_wombat,
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1, shorting_target = 60, } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})
