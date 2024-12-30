local M = {}

M.diagn_symbols = {
    error = "",
    warn = "",
    hint = "󰌶",
    info = "󰋽",
}

M.exclude_filetype = {
    "help",
    "startify",
    "dashboard",
    "TelescopePrompt",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "qf",
    "output",
    ""
}

function M.is_ui_filetype(target_filetype)
    if vim.tbl_contains(M.exclude_filetype, target_filetype) then
        return true
    end

    return false
end

function M.run(cmd)
    require("output").run(cmd, false)
    -- vim.fn.jobstart("sh " .. "$HOME/.cfg/tmux/scripts/send-cmd.bash " .. "'" .. cmd .. "'")
    -- vim.cmd("TermExec cmd='" .. cmd .. "'")
    -- require("terminal").termExec(cmd)
    -- require("wezterm-toggle").exec(cmd)
end

function M.run_silent(cmd)
    require("output").run(cmd, true)
end

-- Detect if nvim mode is insert
function M.is_insert_mode()
    local mode = vim.api.nvim_get_mode().mode
    return mode == "i" or mode == "ic" or mode == "ix" or mode == "R" or mode == "Rc" or mode == "Rx"
end

function M.isempty(s)
    return s == nil or s == ''
end

function M.file_icon(filename, filetype)
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok or not filetype then
        return "", ""
    end

    local icon, color = icons.get_icon_color(filename, filetype)
    if not icon then
        return "", ""
    end

    return icon, color
end

function M.get_buf_option(opt)
    local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
    if not status_ok then
        return nil
    else
        return buf_option
    end
end

return M
