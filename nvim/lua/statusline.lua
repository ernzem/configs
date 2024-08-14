local M = {}
local hl_mode_insert = "ModeInsert"
local hl_mode_normal = "ModeNormal"
local hl_mode_visual = "ModeVisual"
local hl_mode_other = "ModeOther"

M.mode_map = {
    ["n"] = { name = "NORMAL", color = "Statusline" },
    ["no"] = { name = "O-PENDING", color = "Statusline" },
    ["nov"] = { name = "O-PENDING", color = "Statusline" },
    ["noV"] = { name = "O-PENDING", color = "Statusline" },
    ["no\22"] = { name = "O-PENDING", color = "Statusline" },
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
    ["t"] = { name = "TERMINAL", color = "Statusline" },
}

function M.mode()
    local mode_code = vim.api.nvim_get_mode().mode
    if M.mode_map[mode_code] == nil then
        return "%#StatusLine# " .. mode_code
    end

    return "%#" .. M.mode_map[mode_code].color .. "# " .. M.mode_map[mode_code].name
end

local function branch_name()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return "  " .. branch .. " "
    end

    return ""
end

function M.workspace_dir()
    return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function file_icon(filetype)
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

M.Marks = {}
-- M.Mark_paths = {}
M.Mark_keys = { "J", "K", "L" }

function M.file_marks()
    local m = ""

    for _, v in ipairs(M.Mark_keys) do
        local mark = vim.api.nvim_get_mark(v, {})
        if mark[4] == "" then
            goto continue
        end

        local filename = vim.fs.basename(mark[4])
        local ic, icon_cl = file_icon(vim.filetype.match({ filename = filename }))
        -- m = m .. " %#StatusLine# " .. v .. ": " .. "%#" .. icon_cl .. "#" .. ic .. " " .. filename .. " %#StatusLineNC#"
        -- m = m .. " %#" .. icon_cl .. "# " .. v .. ": " .. ic .. " " .. filename .. " %#StatusLineNC#"
        m = m .. " %#StatusLine# " .. v .. ": " .. ic .. " " .. filename .. " %#StatusLineNC#"
        ::continue::
    end

    return m
end

function M.grapple_marks()
    local m = ""
    local t = require("grapple").tags()
    for i, v in ipairs(t) do
        if v.path == nil then
            goto continue
        end

        local filename = vim.fs.basename(v.path)
        local ic, icon_cl = file_icon(vim.filetype.match({ filename = filename }))
        -- m = m .. " %#StatusLine# " .. v .. ": " .. "%#" .. icon_cl .. "#" .. ic .. " " .. filename .. " %#StatusLineNC#"
        -- m = m .. " %#" .. icon_cl .. "# " .. v .. ": " .. ic .. " " .. filename .. " %#StatusLineNC#"
        m = m .. " %#StatusLine# " .. i .. ": " .. ic .. " " .. filename .. " %#StatusLineNC#"
        ::continue::
    end

    return m
end

local mode = "%{%v:lua.require'statusline'.mode()%} "
local git_branch = [[%{luaeval("vim.g.branch_name")}%*]]
local workspace_dir = [[ %{luaeval("require('statusline').workspace_dir()")} %*]]
local tags = "%{%v:lua.require'statusline'.grapple_marks()%}"
local align_right = "%="
local linecol = "%l:%c"
local percentage = "%p%%"
-- local statusline_string = table.concat({
--     mode,
--     "%#StatusLine#",
--     git_branch,
--     "%#StatusLine#",
--     workspace_dir,
--     "%#StatusLineNC#",
--     M.my_marks(),
--     align_right,
--     filetype,
--     "  ",
--     fileencoding,
--     "  ",
--     fileformat,
--     " %#StatusLine# ",
--     linecol,
--     " %#StatusLineNC# ",
--     percentage,
--     " ",
-- })

function Statusline()
    return table.concat({
        mode,
        "%#StatusLine#",
        git_branch,
        "%#StatusLine#",
        workspace_dir,
        "%#StatusLineNC#",
        tags,
        align_right,
        " %#StatusLine# ",
        linecol,
        "  ",
        -- " %#StatusLineNC# ",
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

vim.api.nvim_create_autocmd({ "VimEnter", "InsertEnter", "TermLeave" }, {
    group = statusline_group,
    callback = function()
        vim.opt.statusline = "%!v:lua.Statusline()"
    end,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    group = statusline_group,
    pattern = "*",
    callback = function()
        local statusline_bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg

        local hl_string = vim.api.nvim_get_hl(0, { name = "String" })
        local hl_comment = vim.api.nvim_get_hl(0, { name = "Comment" })
        local hl_function = vim.api.nvim_get_hl(0, { name = "Function" })

        vim.api.nvim_set_hl(0, hl_mode_insert, { fg = hl_string.fg, bg = statusline_bg, bold = true })
        vim.api.nvim_set_hl(0, hl_mode_normal, { fg = hl_comment.fg, bg = statusline_bg })
        vim.api.nvim_set_hl(0, hl_mode_visual, { fg = hl_function.fg, bg = statusline_bg, bold = true })
        vim.api.nvim_set_hl(0, hl_mode_other, { bg = statusline_bg, bold = true })

        vim.opt.statusline = "%!v:lua.Statusline()"
    end,
})

return M
