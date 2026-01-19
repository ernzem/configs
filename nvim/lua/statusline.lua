local M = {}
local hl_mode_insert = "ModeInsert"
local hl_mode_normal = "ModeNormal"
local hl_mode_visual = "ModeVisual"
local hl_mode_other = "ModeOther"

M.mode_map = {
    ["n"] = { name = "NORMAL", color = hl_mode_normal },
    ["no"] = { name = "O-PENDING", color = hl_mode_other },
    ["nov"] = { name = "O-PENDING", color = hl_mode_other },
    ["noV"] = { name = "O-PENDING", color = hl_mode_other },
    ["no\22"] = { name = "O-PENDING", color = hl_mode_other },
    ["niI"] = { name = "NORMAL", color = hl_mode_normal },
    ["niR"] = { name = "NORMAL", color = hl_mode_normal },
    ["niV"] = { name = "NORMAL", color = hl_mode_normal },
    ["nt"] = { name = "NORMAL", color = hl_mode_normal },
    ["ntT"] = { name = "NORMAL", color = hl_mode_normal },
    ["v"] = { name = "VISUAL", color = hl_mode_visual },
    ["vs"] = { name = "VISUAL", color = hl_mode_visual },
    ["V"] = { name = "V-LINE", color = hl_mode_visual },
    ["Vs"] = { name = "V-LINE", color = hl_mode_visual },
    ["\22"] = { name = "V-BLOCK", color = hl_mode_visual },
    ["\22s"] = { name = "V-BLOCK", color = hl_mode_visual },
    ["s"] = { name = "SELECT", color = hl_mode_other },
    ["S"] = { name = "S-LINE", color = hl_mode_other },
    ["\19"] = { name = "S-BLOCK", color = hl_mode_other },
    ["i"] = { name = "INSERT", color = hl_mode_insert },
    ["ic"] = { name = "INSERT", color = hl_mode_insert },
    ["ix"] = { name = "INSERT", color = hl_mode_insert },
    ["r"] = { name = "REPLACE", color = hl_mode_other },
    ["R"] = { name = "REPLACE", color = hl_mode_other },
    ["Rc"] = { name = "REPLACE", color = hl_mode_other },
    ["Rx"] = { name = "REPLACE", color = hl_mode_other },
    ["Rv"] = { name = "V-REPLACE", color = hl_mode_other },
    ["Rvc"] = { name = "V-REPLACE", color = hl_mode_other },
    ["Rvx"] = { name = "V-REPLACE", color = hl_mode_other },
    ["c"] = { name = "COMMAND", color = hl_mode_other },
    ["cv"] = { name = "EX", color = hl_mode_other },
    ["ce"] = { name = "EX", color = hl_mode_other },
    ["rm"] = { name = "MORE", color = hl_mode_other },
    ["r?"] = { name = "CONFIRM", color = hl_mode_other },
    ["!"] = { name = "SHELL", color = hl_mode_other },
    ["t"] = { name = "TERMINAL", color = hl_mode_insert },
}

function M.mode()
    local mode_code = vim.api.nvim_get_mode().mode
    if M.mode_map[mode_code] == nil then
        return "%#StatusLine# " .. mode_code
    end

    return "%#" .. M.mode_map[mode_code].color .. "# " .. M.mode_map[mode_code].name .. " %#StatusLine#"
end

local function branch_name()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return " " .. branch .. " "
    end

    return ""
end

function M.workspace_dir()
    return "   " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

function M.grapple_marks()
    local m = ""
    local hl_mark_icon_name = "StatuslineMarkIcon"
    local statusline_bg = vim.api.nvim_get_hl(0, { name = "Statusline" }).bg

    local t = require("grapple").tags()
    if t == nil then
        return ""
    end

    for index, mark in ipairs(t) do
        if mark.path == nil then
            goto continue
        end

        local filename = vim.fs.basename(mark.path)
        local icon, icon_cl = require("utils").file_icon(filename, vim.filetype.match({ filename = filename }))
        vim.api.nvim_set_hl(0, hl_mark_icon_name .. index, { fg = icon_cl, bg = statusline_bg, bold = true, underline = false })

        m = table.concat({
            m,
            " ",
            index,
            ": ",
            "%#" .. hl_mark_icon_name .. index .. "#",
            icon,
            " ",
            filename,
            "%* "
        })
        ::continue::
    end

    return m
end

 ------------------------------STATUSLINE STRING----------------------------------------

local mode = "%{%v:lua.require'statusline'.mode()%} "
local git_branch = [[%{luaeval("vim.g.branch_name")}]]
local workspace_dir = [[%{luaeval("require('statusline').workspace_dir()")}]]
local align_right = "%="
local linecol = "%l:%c"
local percentage = "%p%%"

function Statusline()
    return table.concat({
        "%#StatusLine#",
        mode,
        git_branch,
        workspace_dir,
        align_right,
        "  ",
        linecol,
        " ",
        percentage,
        " ",
    })
end

 ------------------------------AUTOCOMMANDS----------------------------------------

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
        local hl_normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        local hl_comment = vim.api.nvim_get_hl(0, { name = "Comment" })
        local hl_function = vim.api.nvim_get_hl(0, { name = "Function" })

        vim.api.nvim_set_hl(0, hl_mode_insert, { bg = hl_string.fg, fg = hl_normal.bg, bold = true })
        vim.api.nvim_set_hl(0, hl_mode_normal, { bg = hl_comment.fg, fg = hl_normal.bg, bold = true })
        vim.api.nvim_set_hl(0, hl_mode_visual, { bg = hl_function.fg, fg = hl_normal.bg, bold = true })
        vim.api.nvim_set_hl(0, hl_mode_other, { fg = hl_normal.fg, bold = true })

       -- vim.api.nvim_set_hl(0, hl_mode_insert, { fg = hl_string.fg, bold = true })
        -- vim.api.nvim_set_hl(0, hl_mode_normal, { fg = hl_comment.fg })
        -- vim.api.nvim_set_hl(0, hl_mode_visual, { fg = hl_function.fg, bold = true})
        -- vim.api.nvim_set_hl(0, hl_mode_other, { fg = statusline.bg, bold = true})
        vim.opt.statusline = "%!v:lua.Statusline()"
    end,
})

return M
