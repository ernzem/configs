require('core.output_buffer')

function Run_cmd(command)
    -- Open buffer, if we need to.
    Open_buffer()

    -- Clear the buffer's contents incase it has been used.
    vim.api.nvim_buf_set_lines(Get_buf_nr(), 0, -1, true, { command })

    -- Run the command.
    vim.fn.jobstart(command, {
        stdout_buffered = false,
        on_stdout = Log,
        on_stderr = Log,
    })
end

local attach_to_buffer = function(pattern, command)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("auto-command", { clear = true }),
        pattern = pattern,
        callback = function()
            Run_cmd(command)
        end
    })
end


vim.api.nvim_create_user_command("AutoRun", function()
    print "AutoRun starts now..."
    local pattern = vim.fn.input "Pattern: "
    local command = vim.split(vim.fn.input "Command: ", " ")
    attach_to_buffer(pattern, command)
    Run_cmd(command)
end, {})


vim.api.nvim_create_user_command("AutoStop", function()
    vim.api.nvim_create_augroup("auto-command", { clear = true })
end, {})

local augroup = vim.api.nvim_create_augroup

-- Trim trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("TrimTrailingWhitespaces", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Loads file changes from the disk
-- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
--
--   command = "if mode() != 'c' | checktime | endif",
--   pattern = { "*" },
-- })


vim.api.nvim_create_user_command("NrColumnToggle", function()
    if not vim.opt.nu then
        return
    end

    if vim.opt.relativenumber._value then
        vim.opt.relativenumber = false
    else
        vim.opt.relativenumber = true
    end
end, {})



vim.api.nvim_create_user_command("OutBufferToggle", function()
    Open_buffer()
end, {})
