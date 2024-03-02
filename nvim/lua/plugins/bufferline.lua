return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup({
            options = {
                diagnostics = "nvim_lsp",
                indicator = {
                    style = 'none',
                },
                diagnostics_update_in_insert = false,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " "
                            or (e == "warning" and " " or "i ")
                        s = s .. n .. sym
                    end
                    return s
                end
            },
            highlights = {
                buffer_selected = { italic = false },
                diagnostic_selected = { italic = false },
                hint_selected = { italic = false },
                pick_selected = { italic = false },
                pick_visible = { italic = false },
                pick = { italic = false },
            },
        })


        vim.keymap.set({ "n", "i" }, "<C-'>", '<cmd>BufferLineTogglePin<cr>', { noremap = true, silent = true })

        vim.keymap.set({ "n", "i" }, "<C-1>", '<cmd>BufferLineGoToBuffer 1<cr>', { noremap = true, silent = true })
        vim.keymap.set({ "n", "i" }, "<C-2>", '<cmd>BufferLineGoToBuffer 2<cr>', { noremap = true, silent = true })
        vim.keymap.set({ "n", "i" }, "<C-3>", '<cmd>BufferLineGoToBuffer 3<cr>', { noremap = true, silent = true })
        vim.keymap.set({ "n", "i" }, "<C-4>", '<cmd>BufferLineGoToBuffer 4<cr>', { noremap = true, silent = true })
    end
}
