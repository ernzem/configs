require("nvim-tree").setup({
    filters = {
        custom = { '.DS_Store' }
    },
    git = {
        enable = true
    },
    view = {
        width = 40
    }
})
-- vim.keymap.set("n", "<leader>e", '<cmd>NvimTreeFindFileToggle<CR>',
--     { buffer = nil, noremap = true, silent = true, nowait = true })

-- close buffer tree if we're the last window around
vim.api.nvim_create_autocmd({ "QuitPre" }, {
    group = vim.api.nvim_create_augroup("autoclose_tree", { clear = true }),
    callback = function()
        local wins = vim.api.nvim_list_wins()
        local realwins = #wins - 1 -- the one being closed has to be subtracted
        for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname == "" or bufname:match("NvimTree_") ~= nil then
                realwins = realwins - 1
            end
        end
        if realwins < 1 then
            vim.cmd("NvimTreeClose")
        end
    end,
})
