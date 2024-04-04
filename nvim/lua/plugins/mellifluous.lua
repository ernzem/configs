return {
    "ramojus/mellifluous.nvim",
    event = "VeryLazy",
    config = function()
        require("mellifluous").setup({
            neutral = true, -- set this to false and bg_contrast to 'medium' for original mellifluous (then it was called meliora theme)
            bg_contrast = "hard",
            dim_inactive = true,
            color_set = "mellifluous",
            mellifluous = {
                color_overrides = {
                    dark = {},
                    light = {
                        -- bg = "#FFFFFF",
                        main_keywords = "#9F3E43",
                        other_keywords = "#9F3E43",
                        comments = "#808080",
                        strings = "#6E3918",
                        types = "#6E3918",
                    },
                },
            },
            styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
                comments = { italic = false },
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
                markup = {
                    headings = { bold = true },
                },
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
                cursor_line_number = true,
            },
            plugins = {
                cmp = true,
                gitsigns = true,
                indent_blankline = true,
                nvim_tree = {
                    enabled = true,
                    show_root = false,
                },
                neo_tree = {
                    enabled = true,
                },
                telescope = {
                    enabled = false,
                    nvchad_like = false,
                },
                startify = true,
            },
        })
    end,
}
