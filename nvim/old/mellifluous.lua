require('mellifluous').setup({
    dim_inactive = false,
    color_set = 'mellifluous',
    mellifluous = {
        neutral = true,        -- set this to false and bg_contrast to 'medium' for original mellifluous (then it was called meliora theme)
        bg_contrast = 'hard`', -- options: 'soft', 'medium', 'hard'
        color_overrides = {
            light = {
                -- bg = '#FFFFFF',
                main_keywords = '#843242',
                -- main_keywords = '#233485',
                -- comments = '#AAAAAA',
            }
        }
    },
    styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
        comments = { italic = true },
        conditionals = {},
        folds = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    transparent_background = {
        enabled = false,
        floating_windows = true,
        telescope = true,
        file_tree = true,
        cursor_line = true,
        status_line = false,
    },
    flat_background = {
        line_numbers = true,
        floating_windows = false,
        file_tree = false,
        cursor_line_number = false,
    },
    plugins = {
        cmp = true,
        gitsigns = true,
        indent_blankline = true,
        nvim_tree = {
            enabled = true,
            show_root = true,
        },
        telescope = {
            enabled = true,
            nvchad_like = true,
        },
        startify = true,
    },
})

vim.o.termguicolors = true
vim.opt.background = "light"

-- Highlight cursor line number without line itself
local cursorLineBg = '#E6E6E6'
vim.api.nvim_set_hl(0, "CursorLine", { bg = cursorLineBg })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = vim.api.nvim_get_color_map().fg, bg = cursorLineBg })
