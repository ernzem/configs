local M = {}

function M.run(cmd)
    -- vim.fn.jobstart("sh " .. "$HOME/.cfg/tmux/scripts/send-cmd.bash " .. "'" .. cmd .. "'")
    -- vim.cmd("TermExec cmd='" .. cmd .. "'")
    require('output_buffer').run(cmd)
end

M.ui_buffers = {}
M.ui_buffers['toggleterm'] = true
M.ui_buffers[''] = true
M.ui_buffers['NvimTree'] = true
M.ui_buffers['TelescopePrompt'] = true

return M
