local fn = vim.fn
local api = vim.api

local vertical_split = "v"
local horizontal_split = "h"
local default_orientation = vertical_split
local default_sizes = { v = 0.45, h = 0.30 }
local M = { win_ids = {} }

------------------------------------------------------------------------
local function new_win(win_id)
	return {
		id = win_id,
		orientation = default_orientation,
		size = default_sizes[default_orientation],
	}
end

local function split_size(win)
	if win.orientation == horizontal_split then
		return math.floor(vim.o.lines * win.size)
	end
	return math.floor(vim.o.columns * win.size)
end

------------------------------------------------------------------------
function M.print_state()
	if #M.win_ids == 0 then
		print("{}")
		return
	end

	for k, v in pairs(M.win_ids) do
		print(k, ":", vim.inspect(v))
	end
end

function M.save_split_state(tab)
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

		M.win_ids[tab].orientation = vertical_split
		M.win_ids[tab].size = size
		return
	end

	if max_width then
		local size = api.nvim_win_get_height(0) / vim.o.lines
		-- print("max width detected. Returning horizontal_split with size: ", size)

		M.win_ids[tab].orientation = horizontal_split
		M.win_ids[tab].size = size
		return
	end

	print("Warning: save_split_state: floating window arrangement. Not intended to exit here...")
end

function M.is_visible(buf_id)
	if buf_id == -1 then
		return false
	end

	local win = M.win_ids[api.nvim_get_current_tabpage()]
	if not win then
		return false
	end

	return fn.win_gotoid(win.id) == 1 and api.nvim_win_get_buf(win.id) == buf_id
end

function M.raise(buf_id)
	local win = M.win_ids[api.nvim_get_current_tabpage()]
	if not win then
		win = new_win(-1)
	end

	if win.orientation == vertical_split then
		vim.cmd("bo vsp")
		vim.cmd("vertical resize " .. split_size(win))
	end

	if win.orientation == horizontal_split then
		vim.cmd("bo sp")
		vim.cmd.resize(split_size(win))
	end

	-- Save window id
	local win_id = vim.fn.win_getid()
	M.win_ids[api.nvim_get_current_tabpage()] = new_win(win_id)

	-- Set buffer to a newly created window
	api.nvim_win_set_buf(win_id, buf_id)
end

function M.hide()
	if #(api.nvim_list_wins()) > 1 then
		local tab = api.nvim_get_current_tabpage()
		local win = M.win_ids[tab]

		M.save_split_state(tab)
		api.nvim_win_hide(win.id)

		-- Remove window id by overwriting with not real value
		win.id = -1
	end
end

------------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("TabClosed", {
	group = vim.api.nvim_create_augroup("clean-split-toggle-state", { clear = true }),
	desc = "Toggle output: clean tab split window state",
	callback = function(data)
		-- NOTE: not sure with field to pick for removing tab data
		-- Example of data object:
		-- {
		--   buf = 2,
		--   event = "TabClosed",
		--   file = "2",
		--   group = 26,
		--   id = 49,
		--   match = "2"
		-- }

		M.win_ids[tonumber(data.match)] = nil
	end,
})

return M
