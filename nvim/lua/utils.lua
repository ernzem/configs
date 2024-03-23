local M = {}

function M.run(cmd)
    -- vim.fn.jobstart("sh " .. "$HOME/.cfg/tmux/scripts/send-cmd.bash " .. "'" .. cmd .. "'")
    -- vim.cmd("TermExec cmd='" .. cmd .. "'")
    -- require('output_buffer').run(cmd)
    require("terminal").termExec(cmd)
end

function M.file_icon(filetype)
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok or not filetype then
        return "", ""
    end

    local icon, color = icons.get_icon_by_filetype(filetype)
    if not icon then
        return "", ""
    end

    return icon, color
end

M.ui_buffers = {}
M.ui_buffers[""] = true
M.ui_buffers["NvimTree"] = true
M.ui_buffers["toggleterm"] = true
M.ui_buffers["TelescopePrompt"] = true

return M
