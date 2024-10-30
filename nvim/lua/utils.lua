local M = {}

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

M.diagn_symbols = {
    error = "",
    warn = "",
    hint = "󰌶",
    info = "󰋽",
}

function M.is_ui_filetype(target_filetype)
    if vim.tbl_contains(M.exclude_filetype, target_filetype) then
        return true
    end

    return false
end

function M.run(cmd)
    require("output_buffer").run(cmd)
    -- vim.fn.jobstart("sh " .. "$HOME/.cfg/tmux/scripts/send-cmd.bash " .. "'" .. cmd .. "'")
    -- vim.cmd("TermExec cmd='" .. cmd .. "'")
    -- require("terminal").termExec(cmd)
    -- require("wezterm-toggle").exec(cmd)
end

-- Detect if nvim mode is insert
function M.is_insert_mode()
    local mode = vim.api.nvim_get_mode().mode
    return mode == "i" or mode == "ic" or mode == "ix" or mode == "R" or mode == "Rc" or mode == "Rx"
end

function M.isempty(s)
    return s == nil or s == ''
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
