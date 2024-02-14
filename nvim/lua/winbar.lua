local ui_buffers = require("utils").ui_buffers

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("WINBAR", { clear = true }),
    pattern = { "*" },
    callback = function()
        if vim.bo.filetype == '' or ui_buffers[vim.bo.filetype] == true then
            return
        end
        vim.wo.winbar = "%{expand('%:~:.')} %m"
    end,
})
