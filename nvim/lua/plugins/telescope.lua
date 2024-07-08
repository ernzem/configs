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
            -- Function allows multiple selections
            local select_one_or_multi = function(prompt_bufnr)
                local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                local multi = picker:get_multi_selection()

                if not vim.tbl_isempty(multi) then
                    require("telescope.actions").close(prompt_bufnr)
                    for _, j in pairs(multi) do
                        if j.path ~= nil then
                            vim.cmd(string.format("%s %s", "edit", j.path))
                        end
                    end
                else
                    require("telescope.actions").select_default(prompt_bufnr)
                end
            end

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
                                ["<CR>"] = select_one_or_multi,
                            },
                        },
                    },
                },
                extensions = {},
            })
            -- Load telescope extensions
            pcall(require("telescope").load_extension, "fzf")

            -- See `:help telescope.builtin`
            vim.keymap.set(
                "n",
                "<leader>?",
                require("telescope.builtin").oldfiles,
                { desc = "[?] Find recently opened files" }
            )
            vim.keymap.set(
                "n",
                "<leader>b",
                require("telescope.builtin").buffers,
                { desc = "[ ] Find existing buffers" }
            )
            vim.keymap.set("n", "<leader>/", function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = "[/] Fuzzily search in current buffer" })

            vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
            vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files, { desc = "Search [F]iles" })
            vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set(
                "n",
                "<leader>sw",
                require("telescope.builtin").grep_string,
                { desc = "[S]earch current [W]ord" }
            )
            vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set(
                "n",
                "<leader>sd",
                require("telescope.builtin").diagnostics,
                { desc = "[S]earch [D]iagnostics" }
            )

            local vertical_layout = {
                layout_strategy = "vertical",
                layout_config = { preview_cutoff = 60 },
                fname_width = 100,
                results_title = nil,
            }
            local ivy_theme = require("telescope.themes").get_ivy({
                previewer = false,
                layout_config = { height = 20 },
                show_line = false, -- telescope lsp_implementations specific config
            })

            vim.keymap.set("n", "gr", function()
                require("telescope.builtin").lsp_references(ivy_theme)
            end, { desc = "[G]oto [R]eferences" })
            -- vim.keymap.set("n", "gI", function()
            --     require("telescope.builtin").lsp_implementations(ivy_theme)
            -- end, { desc = "[G]oto [I]mplementation" })

            vim.keymap.set("n", "Gr", function()
                require("telescope.builtin").lsp_references(vertical_layout)
            end, { desc = "[G]oto [R]eferences" })
            vim.keymap.set("n", "<leader>I", function()
                require("telescope.builtin").lsp_implementations(vertical_layout)
            end, { desc = "[G]oto [I]mplementation" })
        end,

        vim.keymap.set("n", "<leader>sn", function()
            require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[S]earch [N]eovim files" }),

        vim.keymap.set("n", "<leader>sc", function()
            require("telescope.builtin").find_files({ cwd = "~/.cfg" })
        end, { desc = "[S]earch [C]onfiguration files" }),
    },
}
