local function send_cmd(pane_id, cmd)
    -- TODO: clear terminal input before executing
    vim.fn.jobstart({ "wezterm", "cli", "send-text", "--no-paste", "--pane-id", pane_id, cmd .. "\r" })
end

local M = {}
local wezcli = "wezterm cli"
M.nvim_pane = tonumber(os.getenv("WEZTERM_PANE"))
M.term_pane = nil
M.split_position = "bottom"
M.split_percentage = 30

function M.get_term_pane()
    local panes = vim.json.decode(vim.fn.system({ wezcli, "list", "--format", "json" }))
    if panes == nil then
        vim.notify("Panes list is nil: failure of listing wezterm panes!")
        return nil
    end
    local tab = nil
    local term_pane = nil

    for _, pane in pairs(panes) do
        if pane.pane_id == M.nvim_pane then
            tab = pane.tab_id
            break
        end
    end

    if tab == nil then
        vim.notify("current wezterm tab is not detected!")
        return nil
    end

    for _, pane in pairs(panes) do
        if pane.tab_id == tab and pane.pane_id ~= M.nvim_pane then
            term_pane = pane
            break
        end
    end

    return term_pane
end

function M.exec(cmd)
    M.term_pane = M.get_term_pane()
    if M.term_pane == nil then
        local new_split_cmd = { wezcli, "split-pane", "--" .. M.split_position, "--percent", M.split_percentage }
        local pane_id = vim.fn.system(new_split_cmd)

        -- Execute cmd to terminal pane
        send_cmd(tonumber(pane_id), cmd)
        return
    end

    -- Make term pane visible by unzooming nvim pane
    vim.fn.jobstart({ wezcli, "zoom-pane", "--unzoom", "--pane-id", M.nvim_pane })

    -- Execute cmd to terminal pane
    send_cmd(M.term_pane.pane_id, cmd)
end

return M
