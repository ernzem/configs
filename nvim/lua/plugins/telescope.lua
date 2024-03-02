return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        lazy = true,
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- Function allows multiple selections
            local select_one_or_multi = function(prompt_bufnr)
                local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                local multi = picker:get_multi_selection()
                if not vim.tbl_isempty(multi) then
                    require('telescope.actions').close(prompt_bufnr)
                    for _, j in pairs(multi) do
                        if j.path ~= nil then
                            vim.cmd(string.format('%s %s', 'edit', j.path))
                        end
                    end
                else
                    require('telescope.actions').select_default(prompt_bufnr)
                end
            end
            require('telescope').setup {
                defaults = {
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                        },
                    },
                    mappings = {
                        i = {
                            ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
                            ['<C-S-Q>'] = require('telescope.actions').delete_buffer,
                            ["<C-h>"] = require('telescope.actions').which_key,
                            ['<CR>'] = select_one_or_multi,
                        }
                    },
                    preview = {
                        hide_on_startup = false
                    }
                },
                pickers = {
                    lsp_implementations = {
                        theme = "cursor"
                    },
                },
                extensions = {
                    file_browser = {
                        layout_config = {
                            horizontal = {
                                prompt_position = "top",
                                preview_width = 0.6,
                                width = 0.95
                            }
                        },
                        path = vim.loop.cwd(),
                        cwd = vim.loop.cwd(),
                        cwd_to_path = false,
                        grouped = true,
                        files = true,
                        add_dirs = true,
                        depth = 1,
                        auto_depth = false,
                        select_buffer = true,
                        hidden = { file_browser = false, folder_browser = false },
                        respect_gitignore = vim.fn.executable "fd" == 1,
                        no_ignore = false,
                        follow_symlinks = true,
                        browse_files = require("telescope._extensions.file_browser.finders").browse_files,
                        browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
                        hide_parent_dir = false,
                        collapse_dirs = false,
                        prompt_path = false,
                        quiet = false,
                        dir_icon = "",
                        dir_icon_hl = "Default",
                        display_stat = false,
                        hijack_netrw = false,
                        use_fd = true,
                        git_status = true,
                    },
                }
            }
            -- Load telescope extensions
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require("telescope").load_extension, "file_browser")

            vim.api.nvim_set_keymap("n", "<leader>e",
                ":lua require 'telescope'.extensions.file_browser.file_browser({path=vim.fn.expand('%:p:h') })<CR>",
                { noremap = true })

            -- See `:help telescope.builtin`
            vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
                { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers,
                { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
            vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Search [F]iles' })
            vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
                { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
                { desc = '[S]earch [D]iagnostics' })


            local vertical_layout = { layout_strategy = 'vertical', layout_config = { preview_cutoff = 60 }, fname_width = 100, results_title = nil }
            local ivy_theme = require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 10 }, fname_width = 100 })

            vim.keymap.set("n", 'gr', function() require('telescope.builtin').lsp_references(ivy_theme) end,
                { desc = '[G]oto [R]eferences' })
            vim.keymap.set("n", 'gI', function() require('telescope.builtin').lsp_implementations(ivy_theme) end,
                { desc = '[G]oto [I]mplementation' })

            vim.keymap.set("n", 'Gr', function() require('telescope.builtin').lsp_references(vertical_layout) end,
                { desc = '[G]oto [R]eferences' })
            vim.keymap.set("n", '<leader>I',
                function() require('telescope.builtin').lsp_implementations(vertical_layout) end,
                { desc = '[G]oto [I]mplementation' })
        end
    },
}
