local M = {}

local fn = vim.fn
local api = vim.api

function M.is_visible(buf_id)
    if buf_id == -1 then
        print("buffer id equals -1")
        return false
    end

    if buf_id == nil then
        print("buffer id equals nil")
        return false
    end

    -- print(buf_id)
    -- print(api.nvim_win_get_buf(0))
    -- print(api.nvim_win_get_buf(0) == buf_id)
	return api.nvim_win_get_buf(0) == buf_id
end

function M.raise(buf_id)
	api.nvim_win_set_buf(0, buf_id)
end

function M.hide()
	vim.cmd("b#")
end

return M
