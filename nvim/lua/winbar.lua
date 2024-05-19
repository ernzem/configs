local M = {}

local save = " %m"
local right_side = "%="

local hl_path = "MsgArea"
local hl_file = "String"
local hl_symbols = "Function"
local hl_file_icon = "WinBarFileIcon"

---------------- Alternative way with custom highlights-------------------
-- local hl_path = "WinBarPath"
-- local hl_file = "WinBarFile"
-- local hl_symbols = "WinBarSymbols"

-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--     pattern = "*",
--     callback = function()
--         local hl_string = vim.api.nvim_get_hl(0, { name = "String" })
--         local hl_winbar_nc = vim.api.nvim_get_hl(0, { name = "WinBarNC" })

-- vim.api.nvim_set_hl(0, hl_file, { fg = hl_string.fg, bg = hl_winbar_nc.bg })

-- local hl_msg_area = vim.api.nvim_get_hl(0, { name = "MsgArea" })
-- vim.api.nvim_set_hl(0, hl_path, { fg = hl_msg_area.fg })

-- vim.api.nvim_set_hl(0, hl_symbols, { fg = opts.colors.symbols })
--     end,
-- })
---------------------------------------------------------------------------

local opts = {
    file_icon_default = "",
    folder_icon = "",
    seperator = "",
    -- seperator = ">",
    editor_state = "●",
    lock_icon = "",
}

local status_web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
local utils = require("utils")

M.file_path = function()
    local value = ""
    local file_icon = ""

    local file_path = vim.fn.expand("%:~:.:h")
    local filename = vim.fn.expand("%:t")
    local file_type = vim.fn.expand("%:e")

    file_path = file_path:gsub("^%.", "")
    file_path = file_path:gsub("^%/", "")

    if utils.isempty(filename) then
        return value
    end

    local default = false
    if utils.isempty(file_type) then
        file_type = ""
        default = true
    end

    if status_web_devicons_ok then
        file_icon = web_devicons.get_icon(filename, file_type, { default = default })
        hl_file_icon = "DevIcon" .. file_type
    end

    if not file_icon then
        file_icon = opts.file_icon_default
    end

    file_icon = "%#" .. hl_file_icon .. "#" .. file_icon .. " %*"

    value = " "
    local file_path_list = {}
    local _ = string.gsub(file_path, "[^/]+", function(w)
        table.insert(file_path_list, w)
    end)

    local path_length = #file_path_list
    if path_length > 0 then
        value = value .. opts.folder_icon .. " "
    end

    for i = 1, path_length do
        local sep = opts.seperator
        if i ~= path_length then
            sep = sep .. " " .. opts.folder_icon
        end

        value = value .. "%#" .. hl_path .. "#" .. file_path_list[i] .. " " .. sep .. " %*"
    end

    value = value .. file_icon .. "%#" .. hl_file .. "#" .. filename -- .. "%*" -- for ending hl_file highlight

    return value
end

function M.lsp_info()
    local count = {}
    local levels = { errors = "Error", warnings = "Warn", info = "Info", hints = "Hint" }

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

local function get_winbar()
    return M.file_path() .. save .. right_side .. M.lsp_info()
end

function M.create()
    if utils.is_ui_filetype(vim.bo.filetype) then
        return
    end

    vim.wo.winbar = get_winbar()
end

function M.update()
    if utils.is_ui_filetype(vim.bo.filetype) or utils.is_insert_mode() then
        return
    end

    -- Attach winbar to all windows/splits that have the same buffer
    for _, id in pairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(id) == vim.api.nvim_get_current_buf() then
            vim.wo[id].winbar = get_winbar()
        end
    end
end

local winbar_autocmd_group = vim.api.nvim_create_augroup("winbar", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = winbar_autocmd_group,
    pattern = "*.*",
    callback = M.create,
})

vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
    group = winbar_autocmd_group,
    pattern = "*.*",
    callback = M.update,
})

return M
