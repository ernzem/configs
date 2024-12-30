local fn = vim.fn
local api = vim.api

local vertical_split = "v"
local horizontal_split = "h"

local default_sizes = {
	v = 0.45,
	h = 0.30,
}

-- TODO: add tab context so that show & hide would work on the same tab only
local M = {
	win_id = -1,
	orientation = vertical_split,
	size = default_sizes[vertical_split],
}


local function split_size()
	if M.orientation == horizontal_split then
		return math.floor(vim.o.lines * M.size)
	end
	return math.floor(vim.o.columns * M.size)
end


function M.save_split_state()
	local ui_tabline = (vim.o.showtabline == 2 or #(api.nvim_list_tabpages()) > 1) and 1 or 0
	local ui_statusline = vim.o.laststatus ~= 0 and 1 or 0

	-- print(ui_tabline)
	-- print(ui_statusline)

	local max_height = api.nvim_win_get_height(0) + vim.o.cmdheight + ui_tabline + ui_statusline == vim.o.lines
	local max_width = api.nvim_win_get_width(0) == vim.o.columns

	-- print(max_height)
	-- print(max_width)

	if max_width and max_height then
		print("Warning: save_split_state: full window arrangement. Not intended to exit here...")
		return
	end

	if max_height then
		local size = api.nvim_win_get_width(0) / vim.o.columns
		-- print("max height detected. Returning vertical_split with size: ", size)

		M.orientation = vertical_split
        M.size = size
		return
	end

	if max_width then
		local size = api.api.nvim_win_get_height(0) / vim.o.lines
		-- print("max width detected. Returning horizontal_split with size: ", size)

		M.orientation = horizontal_split
        M.size = size
		return
	end

	print("Warning: save_split_state: floating window arrangement. Not intended to exit here...")
end

function M.is_visible(buf_id)
	if buf_id == -1 or M.win_id == -1 then
		return false
	end

	return fn.win_gotoid(M.win_id) == 1 and api.nvim_win_get_buf(M.win_id) == buf_id
end

function M.raise(buf_id)
	if M.orientation == vertical_split then
		vim.cmd("bo vsp")
		vim.cmd("vertical resize " .. split_size())
	end

	if M.orientation == horizontal_split then
		vim.cmd("bo sp")
		vim.cmd.resize(split_size())
	end

	M.win_id = vim.fn.win_getid()
	api.nvim_win_set_buf(M.win_id, buf_id)
end

function M.hide()
	if #(api.nvim_list_wins()) > 1 then
		M.save_split_state()
		api.nvim_win_hide(M.win_id)
	end
end


return M
