local file_pattern = '*.lua'

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("luaFormatting", { clear = false }),
    pattern = file_pattern,
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})
