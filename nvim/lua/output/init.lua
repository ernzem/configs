local api = vim.api
local fn = vim.fn
local buffer = "buffer"
local vsplit = "vsplit"
local hsplit = "hsplit"
local M = {
    tab_view = {},
	output = require("output.output_buffer"),
	default_view = 2,
	views = { buffer, vsplit, hsplit },
	methods = {
		buffer = require("output.views.buffer"),
		vsplit = require("output.views.split"),
		hsplit = require("output.views.split"),
	},
}

-------------------------HELPERS---------------------------------
local function get_current_tab_view()
	local tab_id = api.nvim_get_current_tabpage()
	local state = M.tab_view[tab_id]

	if state == nil then
		state = { view_type = M.views[M.default_view] }
		M.tab_view[tab_id] = state
	end

	return tab_id, state, M.methods[state.view_type]
end

local function get_view_state()
	local ui_tabline = (vim.o.showtabline == 2 or #(api.nvim_list_tabpages()) > 1) and 1 or 0
	local ui_statusline = vim.o.laststatus ~= 0 and 1 or 0

	local max_height = api.nvim_win_get_height(0) + vim.o.cmdheight + ui_tabline + ui_statusline == vim.o.lines
	local max_width = api.nvim_win_get_width(0) == vim.o.columns

	if max_width and max_height then
		-- NOTE: buffer_view & tab will exit here. Tab view needs aditional check if exiting in a new tab
		return {
			view_type = buffer,
		}
	end

	if max_height then
		-- print("max height detected. Returning vertical_split with size: ", size)
		return {
			view_type = vsplit,
			size = api.nvim_win_get_width(0) / vim.o.columns,
		}
	end

	if max_width then
		-- print("max width detected. Returning horizontal_split with size: ", size)
		return {
			view_type = hsplit,
			size = api.nvim_win_get_height(0) / vim.o.lines,
		}
	end

	print("Warning: save_split_state: floating window arrangement. Not intended to exit here...")
end

function M.raise(tab_id, state, view)
	view.raise(M.output.buf_id, state)
	M.tab_view[tab_id].win_id = vim.fn.win_getid()
end

function M.hide(tab_id, state, view, save_previous_layout)
	if save_previous_layout then
		M.tab_view[tab_id] = get_view_state()
	end

	view.hide(state)
end

-------------------------EXTERNAL---------------------------------
function M.toggle()
	M.output.ensure_exists()

	local tab_id, state, view = get_current_tab_view()
	if view.is_visible(M.output.buf_id, state) then
		M.hide(tab_id, state, view, true)
	else
		M.raise(tab_id, state, view)
	end
end

function M.run(cmd, silent)
	M.output.ensure_exists()

	local tab_id, state, view = get_current_tab_view()
	if not silent and not view.is_visible(M.output.buf_id, state) then
		M.raise(tab_id, state, view)
	end

	M.output.set_writable()

	-- Clear the buffer's contents incase it has been used.
	api.nvim_buf_set_lines(M.output.buf_id, 0, -1, true, { cmd })

	-- Run the command.
	fn.jobstart(cmd, {
		stdout_buffered = false,
		on_stdout = M.output.write({ silent = silent }),
		on_stderr = M.output.write({ silent = silent }),
		on_exit = function()
			api.nvim_buf_set_lines(M.output.buf_id, -1, -1, true, { "Done." })

			--Avoids nvim errors when exiting nvim
			api.nvim_set_option_value("modified", false, { buf = M.output.buf_id })
			M.output.set_readonly()
		end,
	})
end

function M.switch_layout()
	local tab_id, state, view = get_current_tab_view()

	if view.is_visible(M.output.buf_id, state) then
		-- Don't need to save state, because it will be owerwritten anyway
		M.hide(tab_id, state, view, false)
	end

	M.default_view = M.default_view + 1
	if #M.views < M.default_view then
		M.default_view = 1
	end

	M.tab_view[tab_id] = { view_type = M.views[M.default_view] }
	M.toggle()
end

--------------------------AUTOCOMMANDS----------------------------------------------
vim.api.nvim_create_autocmd("TabClosed", {
	group = vim.api.nvim_create_augroup("clean-split-toggle-state", { clear = true }),
	desc = "Toggle output: clean a closed tab state",
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
		M.tab_view[tonumber(data.match)] = nil
	end,
})

--------------------------KEYMAPS--------------------------------
vim.keymap.set({ "n" }, "<C-s>", M.toggle, { noremap = true })
vim.keymap.set({ "n" }, "<C-a>", function()
	M.switch_layout()
end, { noremap = true })

vim.keymap.set({ "n" }, "<C-e>", function()
	M.run("date", false)
end, { noremap = true })

return M
