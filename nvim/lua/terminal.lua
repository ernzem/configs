local fn = vim.fn
local api = vim.api

------------------------- defaults-----------------------------
local splitv = "split_vertical"
local splith = "split_horizontal"
local fullwindow = "full_window"

local default_layouts = {}
default_layouts[splitv] = 0.45
default_layouts[splith] = 0.30

local M = {}
M.te_buf = nil
M.te_win_id = 0
M.window_type = splitv
M.percentage = default_layouts[M.window_type]
M.te_channel_id = 0
M.run_cmd = false

function M.detect_direction()
    local ui_lines = (vim.o.tabline ~= "" and 1 or 0) + (vim.o.laststatus ~= 0 and 1 or 0)

    local max_height = api.nvim_win_get_height(0) + vim.o.cmdheight + ui_lines == vim.o.lines
    local max_width = api.nvim_win_get_width(0) == vim.o.columns

    if max_width and max_height then
        return fullwindow, 1
    end

    if max_height then
        return splitv, api.nvim_win_get_width(0) / vim.o.columns
    end

    if max_width then
        return splith, api.nvim_win_get_height(0) / vim.o.lines
    end
end

local function save_win_size()
    M.window_type, M.percentage = M.detect_direction()
end

local function split_size()
    if M.window_type == splith then
        return math.floor(vim.o.lines * M.percentage)
    end
    return math.floor(vim.o.columns * M.percentage)
end

local function createWindow()
    if M.window_type == fullwindow then
        return
    end

    if M.window_type == splitv then
        vim.cmd("bo vsp")
        vim.cmd("vertical resize " .. split_size())
    end

    if M.window_type == splith then
        vim.cmd("bo sp")
        vim.cmd.resize(split_size())
    end
end

local function openTerminal()
    createWindow()

    -- Create new terminal buffer?
    if M.te_buf == nil or vim.fn.bufexists(M.te_buf) ~= 1 then
        vim.cmd("au TermOpen * setlocal nonumber norelativenumber signcolumn=no")

        M.te_channel_id = vim.cmd.terminal()

        M.te_buf = fn.bufnr("%")
        M.te_win_id = fn.win_getid()
        return
    end

    -- Terminal exists. Attach to a new window
    M.te_win_id = vim.fn.win_getid()
    api.nvim_win_set_buf(M.te_win_id, M.te_buf)
end

local function hideTerminal()
    if vim.fn.win_gotoid(M.te_win_id) ~= 1 then
        vim.print("Expected terminal window does't exist: " .. M.te_win_id)
        return
    end

    -- Hide if it's a split window. Otherwise, go back to previous buffer
    if #(api.nvim_list_wins()) > 1 then
        api.nvim_win_hide(M.te_win_id)
    else
        vim.cmd("b#")
    end
end

function M.toggleTerminal(cfg)
    if vim.fn.win_gotoid(M.te_win_id) == 1 and api.nvim_win_get_buf(M.te_win_id) == M.te_buf then
        if cfg == nil or cfg.save_win_size == true then
            save_win_size()
        end

        hideTerminal()

        if cfg ~= nil and cfg.reopen == true then
            openTerminal()
        end
    else
        openTerminal()
        vim.cmd.startinsert()
    end
end

-------------------------------------CMD-----------------------------------------------

vim.api.nvim_create_user_command("Ht", function()
    M.window_type = splith
    M.percentage = default_layouts[splith]
    M.toggleTerminal({ reopen = true, save_win_size = false })
end, {})

vim.api.nvim_create_user_command("Vt", function()
    M.window_type = splitv
    M.percentage = default_layouts[splith]
    M.toggleTerminal({ reopen = true, save_win_size = false })
end, {})

vim.api.nvim_create_user_command("Ft", function()
    M.window_type = fullwindow
    M.toggleTerminal({ reopen = true, save_win_size = false })
end, {})

----------------------------------AUTOCMD----------------------------------------------

local terminal_group = vim.api.nvim_create_augroup("terminal", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = terminal_group,
    desc = "Open terminal in insert mode, turn off line numbers",
    callback = function()
        if not M.run_cmd then
            vim.cmd.startinsert()
        end
    end,
})

----------------------------KEYMAP FUNCTIONS------------------------------------------

function M.termExec(cmd)
    local current_focused_window = fn.win_getid()

    -- Open terminal window
    if vim.fn.win_gotoid(M.te_win_id) ~= 1 then
        -- Preventing not to go insert mode in terminal
        local previous_run_cmd_value = M.run_cmd
        M.run_cmd = true

        openTerminal()

        -- return back to previous value
        M.run_cmd = previous_run_cmd_value
    end

    -- FIXME: fix when term normal mode cursor is at the bottom
    vim.cmd("$")

    -- Send Ctrl-U to clean input
    -- vim.api.nvim_chan_send(vim.bo[M.te_buf].channel, '\x30\x78\x31\x35')

    -- Clear terminal window
    vim.api.nvim_chan_send(vim.bo[M.te_buf].channel, "clear\r")

    -- Run a command
    vim.api.nvim_chan_send(vim.bo[M.te_buf].channel, cmd .. "\r")

    -- Bring cursor back if previous window was not a terminal window
    if current_focused_window ~= M.te_win_id then
        vim.api.nvim_command("wincmd p")
    end
end

----------------------------------KEYMAPS----------------------------------------------
vim.keymap.set({ "n", "i", "t" }, "<C-a>", M.toggleTerminal, { desc = "Toggle terminal" })

return M
