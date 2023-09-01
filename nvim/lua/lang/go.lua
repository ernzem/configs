local go_file = '*.go'

vim.api.nvim_create_autocmd("InsertLeavePre", {
    group = vim.api.nvim_create_augroup("goFormatting", { clear = false }),
    pattern = go_file,
    callback = function()
        vim.lsp.buf.format({ async = true })
  end
})

vim.keymap.set('n', '<leader>dt', require('dap-go').debug_test)
vim.keymap.set('n', '<leader>dlt', require('dap-go').debug_last_test)
