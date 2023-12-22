local M = {}

function M.run(cmd)
    -- vim.fn.jobstart("bash ".."$HOME/.cfg/tmux/scripts/send-cmd.bash ".."'"..cmd.."'")
    vim.cmd("TermExec cmd='" .. cmd .. "'")
end

M.ui_buffers = {}
M.ui_buffers['toggleterm'] = true
M.ui_buffers['NvimTree'] = true

return M
