local file_pattern = '*.lua'

vim.api.nvim_create_autocmd("InsertLeavePre", {
    group = vim.api.nvim_create_augroup("luaFormatting", { clear = false }),
    pattern = file_pattern,
    callback = function()
        vim.lsp.buf.format({ async = true })
    end
})
