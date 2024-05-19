local M = {}
local function branch_name()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return " " .. branch
    end
end

function M.workspace_dir()
    return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local align_right = "%="
local fileencoding = "%{&fileencoding?&fileencoding:&encoding}"
local fileformat = "%{&fileformat}"
local filetype = "%y"
local linecol = "%l:%c"
local percentage = "%p%%"
local static_statusline1 = table.concat({
    -- [[ %{luaeval("require('statusline').mode()")} %*]],
    "%#StatusLine#",
    [[ %{luaeval("vim.g.branch_name")} %*]],
    "%#StatusLine#",
    [[ %{luaeval("require('statusline').workspace_dir()")} %*]],
    "%#StatusLine#",
})

local static_statusline2 = table.concat({
    --TODO: modify to be static and only update with keyboard
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
})

function Statusline()
    return static_statusline1 .. static_statusline2
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

return M
