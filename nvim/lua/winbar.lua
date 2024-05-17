-- WinBar parts
local save = "%#WinBar#%m "
-- local right_side = "%="
local path = "%#WinBarNC#%{expand('%:h')}/%#WinBarNC#"
local filename = "%{expand('%:t')}"

-- local default_winbar = filename .. "%#WinBar#" .. save .. right_side
-- Static winbar sting
local default_winbar = filename .. "%#WinBar#"

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

    return errors .. warnings .. hints .. info .. " "
end

local function icon_with_color()
    local icon, color = require("utils").file_icon(vim.bo.filetype)
    return " %#" .. color .. "#" .. icon .. "%* "
end

-- Variables for autocommands
local ui_buffers = require("utils").ui_buffers
local M = {}

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

function M.create()
    if ui_buffers[vim.bo.filetype] == true then
        return
    end

    vim.wo.winbar = "%#WinBar#" ..
        save .. path .. "%#WinBar#" .. icon_with_color() .. default_winbar .. lsp_info() .. "%#WinBar#"
end

function M.update()
    -- NOTE: Maybe if picking diagnostics data from event, i can delete "is_insert" method?
    if ui_buffers[vim.bo.filetype] == true or is_insert() then
        return
    end

    attach_winbar("%#WinBar#" ..
        save .. path .. "%#WinBar#" .. icon_with_color() .. default_winbar .. lsp_info() .. "%#WinBar#")
end

local winbar_group = vim.api.nvim_create_augroup("winbar", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = winbar_group,
    pattern = "*.*",
    callback = M.create,
})

vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
    group = winbar_group,
    pattern = "*.*",
    callback = M.update,
})

-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--     group = winbar_group,
--     pattern = "*",
--     callback = function()
--         vim.api.nvim_set_hl(0, "WinBar", { bold = true })
--     end,
-- })
return M
