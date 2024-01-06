vim.api.nvim_create_user_command("MDpreview", function()
    local file = vim.api.nvim_buf_get_name(0)
    vim.fn.jobstart('open ' .. file)
end, {})
