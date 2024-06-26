local M = {}
local output_buf_nr = -1
local output_buf_name = 'OUTPUT'

function M.run(command)
    -- Open buffer, if we need to.
    Open_buffer()

    -- Mark output buffer writable
    vim.api.nvim_buf_set_option(output_buf_nr, "readonly", false)

    -- Clear the buffer's contents incase it has been used.
    vim.api.nvim_buf_set_lines(output_buf_nr, 0, -1, true, { command })

    -- Run the command.
    vim.fn.jobstart(command, {
        stdout_buffered = false,
        on_stdout = Log,
        on_stderr = Log,
    })
end

-- FROM https://stackoverflow.com/questions/75141843/create-a-temporary-readonly-buffer-for-test-output
function Log(_, data)
    if data then
        -- Make it temporarily writable so we don't have warnings.
        vim.api.nvim_buf_set_option(output_buf_nr, "readonly", false)

        -- Append the data.
        vim.api.nvim_buf_set_lines(output_buf_nr, -1, -1, true, data)

        -- Make readonly again.
        vim.api.nvim_buf_set_option(output_buf_nr, "readonly", true)

        -- Mark as not modified, otherwise you'll get an error when
        -- attempting to exit vim.
        vim.api.nvim_buf_set_option(output_buf_nr, "modified", false)

        -- Get the window the buffer is in and set the cursor position to the bottom.
        local buffer_window = vim.api.nvim_call_function("bufwinid", { output_buf_nr })
        local buffer_line_count = vim.api.nvim_buf_line_count(output_buf_nr)
        vim.api.nvim_win_set_cursor(buffer_window, { buffer_line_count, 0 })
    end
end

function Open_buffer()
    -- Get a boolean that tells us if the buffer number is visible anymore.
    local buffer_visible = vim.api.nvim_call_function("bufwinnr", { output_buf_nr }) ~= -1

    if output_buf_nr == -1 or not buffer_visible then
        -- Create a new buffer with the name from output_buf_name variable.
        -- Same name will reuse the current buffer.
        vim.api.nvim_command('botright vsplit ' .. output_buf_name)

        -- Collect the buffer's number.
        output_buf_nr = vim.api.nvim_get_current_buf()

        -- Set filetype so custom behavios/settings could be applied.
        vim.api.nvim_buf_set_option(output_buf_nr, "filetype", "output")

        -- Bring cursor back to previous buffer
        vim.api.nvim_command('wincmd p')
    end
end

return M
