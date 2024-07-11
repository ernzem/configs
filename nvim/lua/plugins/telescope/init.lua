return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        -- event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.65,
                        },
                        cursor = {
                            height = 4,
                            preview_cutoff = 40,
                            width = 0.8,
                        },
                    },
                    mappings = {
                        i = {
                            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                            ["<C-R>"] = require("telescope.actions").delete_buffer,
                            ["<C-h>"] = require("telescope.actions").which_key,
                            ["<C-Space>"] = { "<esc>", type = "command" },
                            ["<esc>"] = require("telescope.actions").close,
                        },
                    },
                    preview = {
                        hide_on_startup = false,
                    },
                },
                pickers = {
                    lsp_implementations = {
                        theme = "ivy",
                        show_line = "false",
                    },
                    find_files = {
                        mappings = {
                            i = {
                                ["<CR>"] = require("plugins.telescope.multi_select").Edit_multi_files
                            },
                        },
                    },
                },
                extensions = {},
            })
            -- Load telescope extensions
            pcall(require("telescope").load_extension, "fzf")

            -- Keymaps
            require("plugins.telescope.keymaps")
        end,
    },
}
