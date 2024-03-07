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
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#LineNr#"
    if current_mode == "n" then
        mode_color = "%#ModeMsg#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#IncSearch#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#StatuslineVisualAccent#"
    elseif current_mode == "R" then
        mode_color = "%#StatuslineReplaceAccent#"
    elseif current_mode == "c" then
        mode_color = "%#StatuslineCmdLineAccent#"
    elseif current_mode == "t" then
        mode_color = "%#StatuslineTerminalAccent#"
    end
    return mode_color
end

function M.mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format("%s", modes[current_mode]):upper()
end

function M.git_branch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")

    if string.len(branch) > 0 then
        return " " .. branch .. " "
    else
        return ""
    end
end

function M.workspace_dir()
    return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

function Statusline()
    local align_right = "%="
    local fileencoding = "%{&fileencoding?&fileencoding:&encoding}"
    local fileformat = "%{&fileformat}"
    local filetype = "%y"
    local linecol = "%l:%c"
    local percentage = "%p%%"

    return table.concat {
        "%#LineNr#",
        [[ %{luaeval("require('statusline').git_branch()")}%*]],
        "%#LineNr#",
        [[ %{luaeval("require('statusline').workspace_dir()")} %*]],
        "%#LineNr#",
        align_right,
        filetype,
        "  ",
        fileencoding,
        "  ",
        fileformat,
        "  ",
        linecol,
        "  ",
        percentage,
        " ",
    }
end

vim.opt.showmode = true
vim.opt.statusline = '%!luaeval("Statusline()")'
vim.opt.cmdheight = 1
return M
