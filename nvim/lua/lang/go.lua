local go_file = '*.go'

-- vim.api.nvim_create_autocmd("InsertLeavePre", {
--     group = vim.api.nvim_create_augroup("goFormatting", { clear = false }),
--     pattern = go_file,
--     callback = function()
--         vim.lsp.buf.format({ async = true })
--   end
-- })

----------------------------CLI Tool Behave Like LSP------------------------------------
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("goFormatting", { clear = false }),
    pattern = go_file,
    callback = function()
        local command = 'golangci-lint run ' .. vim.api.nvim_buf_get_name(0) .. ' --fast --out-format json'
        local bufnr = vim.api.nvim_get_current_buf()
        local ns = vim.api.nvim_create_namespace "live-tests"
        local issues = {}

        vim.fn.jobstart(command, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if not data then
                    return
                end

                for _, line in ipairs(data) do
                    if line == '' then
                        goto continue
                    end
                    local decoded = vim.json.decode(line)
                    for _, issue in pairs(decoded.Issues) do
                        table.insert(issues, issue)
                    end
                    ::continue::
                end
            end,

            on_exit = function()
                local failed = {}
                for _, issue in pairs(issues) do
                    vim.print(issue)
                    table.insert(failed, {
                        bufnr = bufnr,
                        lnum = issue.Pos.Line - 1,
                        col = issue.Pos.Column - 1,
                        severity = vim.diagnostic.severity.ERROR,
                        source = issue.FromLinter,
                        message = issue.FromLinter .. ': '.. issue.Text,
                        user_data = {},
                    })
                end

                vim.diagnostic.set(ns, bufnr, failed, {})
            end,
        })
    end
})
-------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>dt', require('dap-go').debug_test)
vim.keymap.set('n', '<leader>dlt', require('dap-go').debug_last_test)
