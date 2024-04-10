local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local M = {}
function M.update_mode_colors()
    local current_mode = vim.fn.mode()
    local mode_color = "%#Statusline#"
    if current_mode == "n" then
        mode_color = "%#Statusline#"
        -- elseif current_mode == "i" or current_mode == "ic" then
        --     mode_color = "%#IncSearch#"
        -- elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        --     mode_color = "%#StatuslineVisualAccent#"
        -- elseif current_mode == "R" then
        --     mode_color = "%#StatuslineReplaceAccent#"
        -- elseif current_mode == "c" then
        --     mode_color = "%#StatuslineCmdLineAccent#"
        -- elseif current_mode == "t" then
        --     mode_color = "%#StatuslineTerminalAccent#"
    end
    return mode_color
end

function M.mode()
    return modes[vim.fn.mode()]
end

local function branch_name()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return " " .. branch
    end
end

function M.workspace_dir()
    return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

M.Marks = {}
M.Mark_paths = {}
M.Mark_keys = { "J", "K", "L" }
function M.my_marks()
    local marks = ""

    for _, v in ipairs(M.Mark_keys) do
        if M.Marks[v] == nil then
            goto continue
        end

        if M.Mark_paths[M.Marks[v]] == nil then
            goto continue
        end

        local icon, _ = require("utils").file_icon(vim.bo.filetype)
        marks = marks .. " %#Search# " .. v .. ": " .. icon .. " " .. M.Mark_paths[M.Marks[v]] .. " %#Statusline#"
        ::continue::
    end

    return marks
end

local function set_mark(key)
    --TODO: vim.api.nvim_get_mark(:, opts)
    local buf_path = vim.api.nvim_buf_get_name(0)
    M.Marks[key] = buf_path
    M.Mark_paths[buf_path] = vim.fn.expand("%:t")
end

local align_right = "%="
local fileencoding = "%{&fileencoding?&fileencoding:&encoding}"
local fileformat = "%{&fileformat}"
local filetype = "%y"
local linecol = "%l:%c"
local percentage = "%p%%"
local static_statusline1 = table.concat({
    -- [[ %{luaeval("require('statusline').mode()")} %*]],
    "%#Statusline#",
    [[ %{luaeval("vim.g.branch_name")} %*]],
    "%#Statusline#",
    [[ %{luaeval("require('statusline').workspace_dir()")} %*]],
    "%#Statusline#",
})

local static_statusline2 = table.concat({
    --TODO: modify to be static and only update with keyboard
    align_right,
    filetype,
    "  ",
    fileencoding,
    "  ",
    fileformat,
    " %#Statusline# ",
    linecol,
    " %#Statusline# ",
    percentage,
    " %*",
})

function Statusline()
    -- return M.update_mode_colors() .. static_statusline1 .. M.my_marks() .. static_statusline2
    return static_statusline1 .. M.my_marks() .. static_statusline2
end

local statusline = "%!v:lua.Statusline()"
vim.opt.statusline = statusline

local statusline_group = vim.api.nvim_create_augroup("statusline", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "FocusGained" }, {
    group = statusline_group,
    callback = function()
        vim.g.branch_name = branch_name()
    end,
})

-- Sort bug which hides statusline when entered to insert mode with vim.opt.cmdheight = 0
vim.api.nvim_create_autocmd({ "InsertEnter", "TermLeave" }, {
    group = statusline_group,
    callback = function()
        vim.opt.statusline = statusline
    end,
})

vim.keymap.set("n", "mJ", function()
    local key = M.Mark_keys[1]
    set_mark(key)
    vim.cmd("mark " .. key)

    statusline = "%!v:lua.Statusline()"
    vim.opt.statusline = statusline
end)

vim.keymap.set("n", "mK", function()
    local key = M.Mark_keys[2]
    set_mark(key)
    vim.cmd("mark " .. key)

    statusline = "%!v:lua.Statusline()"
    vim.opt.statusline = statusline
end)

vim.keymap.set("n", "mL", function()
    local key = M.Mark_keys[3]
    set_mark(key)
    vim.cmd("mark " .. key)

    statusline = "%!v:lua.Statusline()"
    vim.opt.statusline = statusline
end)

return M
