local api = vim.api
local M = {}

function M.is_visible(buf_id, _)
    if buf_id == -1 then
        print("buffer id equals -1")
        return false
    end

    if buf_id == nil then
        print("buffer id equals nil")
        return false
    end

	return api.nvim_win_get_buf(0) == buf_id
end

function M.raise(buf_id, _)
	api.nvim_win_set_buf(0, buf_id)
end

function M.hide(_)
	vim.cmd("b#")
end

return M
