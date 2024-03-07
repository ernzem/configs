-- Winbar parts
local save = " %m"
local right_side = "%="
local path = "%#LineNr# %{expand('%:h')}/%#Normal#"
local filename = "%{expand('%:t')}"

-- Static winbar sting
local default_winbar = path .. filename .. save .. right_side

local function lsp_info()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = " %#DiagnosticSignError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#DiagnosticSignWarn# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#DiagnosticSignHint#󰌶 " .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#DiagnosticSignInfo#󰋽 " .. count["info"]
    end

    return errors .. warnings .. hints .. info .. "%#Normal# "
end

local function file_icon(filetype)
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok or not filetype then
        return ""
    end

    local icon, color = icons.get_icon_by_filetype(filetype)
    if not icon then
        return ""
    end

    return " %#" .. color .. "#" .. icon .. "%#Normal#"
end

-- Detect if nvim mode is insert
local function is_insert()
    local mode = vim.api.nvim_get_mode().mode
    return mode == "i" or mode == "ic" or mode == "ix" or mode == "R" or mode == "Rc" or mode == "Rx"
end

-- Attach winbar to all windows/splits that have the same buffer
local function attach_winbar(winbar)
    local target_bufnr = vim.api.nvim_get_current_buf()
    for _, id in pairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(id) == target_bufnr then
            vim.wo[id].winbar = winbar
        end
    end
end

-- Variables for autocommands
local ui_buffers = require("utils").ui_buffers
local M = {}

function M.create()
    if ui_buffers[vim.bo.filetype] == true then
        return
    end

    vim.wo.winbar = file_icon(vim.bo.filetype) .. default_winbar .. lsp_info()
end

function M.update()
    -- NOTE: Maybe if picking diagnostics data from event, i can delete "is_insert" method?
    if ui_buffers[vim.bo.filetype] == true or is_insert() then
        return
    end

    attach_winbar(file_icon(vim.bo.filetype) .. default_winbar .. lsp_info())
end

local winbar_group = vim.api.nvim_create_augroup("winbar", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = winbar_group,
    pattern = "*.*",
    callback = M.create
})

vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
    group = winbar_group,
    pattern = "*.*",
    callback = M.update
})

return M
