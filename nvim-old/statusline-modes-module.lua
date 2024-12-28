local M = {}
local hl_mode_insert = "ModeInsert"
local hl_mode_normal = "ModeNormal"
local hl_mode_visual = "ModeVisual"
local hl_mode_other = "ModeOther"
local hl_marks = "MarksStatusline"

M.mode_map = {
    ["n"] = { name = "NORMAL", color = "Statusline" },
    ["no"] = { name = "O-PENDING", color = "Statusline" },
    ["nov"] = { name = "O-PENDING", color = "Statusline" },
    ["noV"] = { name = "O-PENDING", color = "Statusline" },
    ["no\22"] = { name = "O-PENDING", color = "Statusline" },
    ["niI"] = { name = "NORMAL", color = hl_mode_normal },
    ["niR"] = { name = "NORMAL", color = hl_mode_normal },
    ["niV"] = { name = "NORMAL", color = hl_mode_normal }, ["nt"] = { name = "NORMAL", color = hl_mode_normal },
    ["ntT"] = { name = "NORMAL", color = hl_mode_normal },
    ["v"] = { name = "VISUAL", color = hl_mode_visual },
    ["vs"] = { name = "VISUAL", color = hl_mode_visual },
    ["V"] = { name = "V-LINE", color = hl_mode_visual },
    ["Vs"] = { name = "V-LINE", color = hl_mode_visual },
    ["\22"] = { name = "V-BLOCK", color = hl_mode_visual },
    ["\22s"] = { name = "V-BLOCK", color = hl_mode_visual },
    ["s"] = { name = "SELECT", color = "Statusline" },
    ["S"] = { name = "S-LINE", color = "Statusline" },
    ["\19"] = { name = "S-BLOCK", color = "Statusline" },
    ["i"] = { name = "INSERT", color = hl_mode_insert },
    ["ic"] = { name = "INSERT", color = hl_mode_insert },
    ["ix"] = { name = "INSERT", color = hl_mode_insert },
    ["r"] = { name = "REPLACE", color = "Statusline" },
    ["R"] = { name = "REPLACE", color = "Statusline" },
    ["Rc"] = { name = "REPLACE", color = "Statusline" },
    ["Rx"] = { name = "REPLACE", color = "Statusline" },
    ["Rv"] = { name = "V-REPLACE", color = "Statusline" },
    ["Rvc"] = { name = "V-REPLACE", color = "Statusline" },
    ["Rvx"] = { name = "V-REPLACE", color = "Statusline" },
    ["c"] = { name = "COMMAND", color = "Statusline" },
    ["cv"] = { name = "EX", color = "Statusline" },
    ["ce"] = { name = "EX", color = "Statusline" },
    ["rm"] = { name = "MORE", color = "Statusline" },
    ["r?"] = { name = "CONFIRM", color = "Statusline" },
    ["!"] = { name = "SHELL", color = "Statusline" },
    ["t"] = { name = "T", color = "Statusline" },
}
function M.mode()
    local mode_code = vim.api.nvim_get_mode().mode
    if M.mode_map[mode_code] == nil then
        return "%#StatusLine# " .. mode_code
    end

    return "%#" .. M.mode_map[mode_code].color .. "# " .. M.mode_map[mode_code].name
end


local mode = "%{%v:lua.require'statusline'.mode()%} "

function Statusline()
    return table.concat({
        "%#StatusLine#",
        " ",
        mode,
    })
end

local statusline_group = vim.api.nvim_create_augroup("statusline", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter", "FocusGained" }, {
    group = statusline_group,
    callback = function()
        vim.g.branch_name = branch_name()
    end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "TermLeave" }, {
    group = statusline_group,
    callback = function()
        vim.opt.statusline = "%!v:lua.Statusline()"
    end,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
    group = statusline_group,
    pattern = "*",
    callback = function()
        local statusline = vim.api.nvim_get_hl(0, { name = "StatusLine" })

        local hl_string = vim.api.nvim_get_hl(0, { name = "String" })
        local hl_comment = vim.api.nvim_get_hl(0, { name = "Comment" })
        local hl_function = vim.api.nvim_get_hl(0, { name = "Function" })

        vim.api.nvim_set_hl(0, hl_mode_insert, { bg = hl_string.fg,})
        vim.api.nvim_set_hl(0, hl_mode_normal, { bg = hl_comment.bg, })
        vim.api.nvim_set_hl(0, hl_mode_visual, { bg = hl_function.bg })
        vim.api.nvim_set_hl(0, hl_mode_other, { bg = statusline.bg })
        vim.api.nvim_set_hl(0, hl_marks, { bg=statusline.bg, fg=statusline.fg, bold = false, underline = true })

        vim.opt.statusline = "%!v:lua.Statusline()"
    end,
})

return M
