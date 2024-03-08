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
        mode_color = "%#LineNr#"
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
        M.update_mode_colors(),
        [[ %{luaeval("require('statusline').mode()")} %*]],
        "%#Normal#",
        [[ %{luaeval("vim.g.branch_name")} ]],
        "%#Normal# ",
        [[ %{luaeval("require('statusline').workspace_dir()")} ]],
        "%#LineNr#",
        align_right,
        filetype,
        "  ",
        fileencoding,
        "  ",
        fileformat,
        " %#Normal# ",
        linecol,
        " %#LineNr# ",
        percentage,
        " ",
    }
end

local statusline = '%!v:lua.Statusline()'

vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.statusline = statusline

local statusline_group = vim.api.nvim_create_augroup("statusline", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "FocusGained" }, {
    group = statusline_group,
    callback = function()
        vim.g.branch_name = branch_name()
    end
})

-- Sort bug which hides statusline when entered to insert mode with vim.opt.cmdheight = 0
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    group = statusline_group,
    callback = function()
        vim.opt.statusline = statusline
    end
})

return M
