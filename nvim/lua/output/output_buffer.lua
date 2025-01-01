local api = vim.api
-- local fn = vim.fn
local M = {
	buf_id = -1,
	name = "OUTPUT",
}

function M.set_writable()
	api.nvim_set_option_value("readonly", false, { buf = M.buf_id })
	api.nvim_set_option_value("modifiable", true, { buf = M.buf_id })
end

function M.set_readonly()
	api.nvim_set_option_value("readonly", true, { buf = M.buf_id })
	api.nvim_set_option_value("modifiable", false, { buf = M.buf_id })
end

function M.write(cfg)
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

		-- Write to buffer
		api.nvim_buf_set_lines(M.buf_id, -1, -1, true, data)

		-- If output buffer is not hidden, move cursor to bottom
		if not cfg.output_buffer_hidden then
			api.nvim_win_set_cursor(0, { api.nvim_buf_line_count(M.buf_id), 0 })
		end
	end
end

function M.ensure_exists()
	if vim.api.nvim_buf_is_valid(M.buf_id) then
		return
	end

	M.buf_id = api.nvim_create_buf(true, false)

	api.nvim_set_option_value("filetype", "output", { buf = M.buf_id })
	api.nvim_buf_set_name(M.buf_id, M.name)

	M.set_readonly()
end

return M
