local api = vim.api
local fn = vim.fn

local buf_view = "buffer_view"
local split_view = "split_view"
-- local tab_view = "tab_view"

local M = {
	name = "OUTPUT",
	state = {
		buf_id = -1,
		-- current_view = buf_view,
		current_view = split_view,
	},
	buffer_view = require("output.views.buffer"),
	split_view = require("output.views.split"),
}

-------------------------Local---------------------------------

local function make_output_writable()
	api.nvim_set_option_value("readonly", false, { buf = M.state.buf_id })
	api.nvim_set_option_value("modifiable", true, { buf = M.state.buf_id })
end

local function make_output_readonly()
	api.nvim_set_option_value("readonly", true, { buf = M.state.buf_id })
	api.nvim_set_option_value("modifiable", false, { buf = M.state.buf_id })
end

local function ensure_output_buffer_exists()
	if vim.api.nvim_buf_is_valid(M.state.buf_id) then
		return
	end

	M.state.buf_id = api.nvim_create_buf(true, false)

	api.nvim_set_option_value("filetype", "output", { buf = M.state.buf_id })
	api.nvim_buf_set_name(M.state.buf_id, M.name)
	make_output_readonly()
end

local function write(silent)
	return function(_, data)
		if not data then
			return
		end

        -- Return if data is empty string
		local len = #data
		if len == 1 and data[len] == "" then
			return
		end

        -- Remove last empty line when multiple lines are in data object
		if data[len] == "" then
			table.remove(data, len)
		end

		api.nvim_buf_set_lines(M.state.buf_id, -1, -1, true, data)
		if not silent then
			-- Move cursor position to the bottom.
			api.nvim_win_set_cursor(0, { api.nvim_buf_line_count(M.state.buf_id), 0 })
		end
	end
end

-------------------------EXTERNAL---------------------------------

function M.toggle()
	ensure_output_buffer_exists()
	local view = M[M.state.current_view]

	if view.is_visible(M.state.buf_id) then
		view.hide()
	else
		view.raise(M.state.buf_id)
	end
end

function M.run(cmd, silent)
	ensure_output_buffer_exists()

	local view = M[M.state.current_view]
	if not silent and not view.is_visible(M.state.buf_id) then
		view.raise(M.state.buf_id)
	end

	make_output_writable()

	-- Clear the buffer's contents incase it has been used.
	api.nvim_buf_set_lines(M.state.buf_id, 0, -1, true, { cmd })

	-- Run the command.
	fn.jobstart(cmd .. '&& echo "Done."', {
		stdout_buffered = false,
		on_stdout = write(silent),
		on_stderr = write(silent),
		on_exit = function()
			--Avoids nvim errors when exiting nvim
			api.nvim_set_option_value("modified", false, { buf = M.state.buf_id })
			make_output_readonly()
		end,
	})
end

--------------------------KEYMAPS--------------------------------
vim.keymap.set({ "n" }, "<C-s>", M.toggle, { noremap = true })
vim.keymap.set({ "n" }, "<C-e>", function()
	M.run("date", true)
end, { noremap = true })

return M
