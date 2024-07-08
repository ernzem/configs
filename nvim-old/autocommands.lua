-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_create_autocmd({'FileChangedShellPost'}, {
  pattern = '*',
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})
