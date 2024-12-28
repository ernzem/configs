local M = {}
local hl_marks = "MarksStatusline"

local function branch_name()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return "  " .. branch
    end

    return ""
end

function M.workspace_dir()
    return "|  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t").. " |"
end

local function file_icon(filename, filetype)
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
        local icon, icon_cl = file_icon(filename, vim.filetype.match({ filename = filename }))

        vim.api.nvim_set_hl(0, hl_mark_icon_name .. index, { fg = icon_cl, bg = statusline_bg, bold = true, underline= false })
        m = table.concat({
            m,
            " ",
            "%#" .. hl_marks .. "#",
            index,
            ": ",
            "%#" .. hl_mark_icon_name .. index .. "#",
            icon,
            "%#" .. hl_marks .. "#",
            " ",
            filename,
            "%* "
        })
        ::continue::
    end

    return m
end

local git_branch = [[%{luaeval("vim.g.branch_name")}]]
local workspace_dir = [[%{luaeval("require('statusline').workspace_dir()")}]]
local tags = "%{%v:lua.require'statusline'.grapple_marks()%}"
local align_right = "%="
local linecol = "%l:%c"
local percentage = "%p%%"

function Statusline()
    return table.concat({
        "%#StatusLine#",
        " ",
        git_branch,
        " ",
        workspace_dir,
        " ",
        tags,
        align_right,
        "| ",
        linecol,
        " | ",
        percentage,
        " ",
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
        vim.api.nvim_set_hl(0, hl_marks, { bg=statusline.bg, fg=statusline.fg, bold = false, underline = false })
        vim.opt.statusline = "%!v:lua.Statusline()"
    end,
})

return M
