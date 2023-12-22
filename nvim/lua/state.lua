local M = {}
local ui_buffers = require("utils").ui_buffers

M.state = {}

vim.api.nvim_create_autocmd({ "BufLeave" }, {
    group = vim.api.nvim_create_augroup("SavePrevBufferDir", {}),
    pattern = "*",
    callback = function()
        local buffer_path = vim.api.nvim_buf_get_name(0)
        if vim.bo.filetype == '' or buffer_path == nil or vim.bo.filetype == nil or ui_buffers[vim.bo.filetype] == true then
            return
        end
        M.state['PrevBuffPath'] = buffer_path
    end
})

return M
