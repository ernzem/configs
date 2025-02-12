local fn = vim.fn
local api = vim.api
local M = {
	vertical_split = "vsplit",
	horizontal_split = "hsplit",
	default_sizes = { vsplit = 0.45, hsplit = 0.30 },
}

local function get_size(state)
	if state.size == nil then
		return M.default_sizes[state.view_type]
	end

    return state.size
end

local function split_size(state)
	local size = get_size(state)
	if state.view_type == M.horizontal_split then
		return math.floor(vim.o.lines * size)
	end
	return math.floor(vim.o.columns * size)
end

function M.is_visible(buf_id, state)
	if buf_id == -1 or state.win_id == -1 then
		return false
	end

	return fn.win_gotoid(state.win_id) == 1 and api.nvim_win_get_buf(state.win_id) == buf_id
end

function M.raise(buf_id, state)
	if state.view_type == M.vertical_split then
		vim.cmd("bo vsp")
		vim.cmd("vertical resize " .. split_size(state))
	end

	if state.view_type == M.horizontal_split then
		vim.cmd("bo sp")
		vim.cmd.resize(split_size(state))
	end

	api.nvim_win_set_buf(vim.fn.win_getid(), buf_id)
end

function M.hide(state)
	if #(api.nvim_list_wins()) > 1 then
		api.nvim_win_hide(state.win_id)
	end
end

return M
