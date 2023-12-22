local backlist = {}
backlist['toggleterm'] = true
backlist['NvimTree'] = true

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("WINBAR", { clear = true }),
    pattern = { "*" },
    callback = function()
        if vim.bo.filetype == '' or backlist[vim.bo.filetype] == true then
            return
        end

        -- vim.print(vim.bo.filetype)
        vim.wo.winbar = " %f %m"
    end,
})
