function Run_cmd(cmd)
    vim.fn.jobstart("bash ".."$HOME/.cfg/tmux/scripts/send-cmd.bash ".."'"..cmd.."'")
end

Attach_to_buffer = function(pattern, command)
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
    local cmdRaw = vim.fn.input "Command: "
    Attach_to_buffer(pattern, cmdRaw)
    Run_cmd(cmdRaw)
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
