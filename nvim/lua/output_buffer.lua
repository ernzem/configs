local fn = vim.fn
local api = vim.api
------------------------- OLD VARS-----------------------------
local M = {}
local output_buf_nr = -1
local output_buf_name = "OUTPUT"

local vertical_split = "split_vertical"
local horizontal_split = "split_horizontal"

local default_layouts = {}
default_layouts[vertical_split] = 0.45
default_layouts[horizontal_split] = 0.30

local function split_size(split_type)
    return math.floor(vim.o.columns * default_layouts[split_type])
end

local function create_or_raise_buffer()
    -- Create a new buffer with the name from output_buf_name variable.
    -- Same name will reuse the current buffer.
    vim.cmd("botright vsplit " .. output_buf_name)
    vim.cmd("vertical resize " .. split_size(vertical_split))

    -- Collect the buffer's number.
    output_buf_nr = api.nvim_get_current_buf()

    -- Bring cursor back to previous buffer
    api.nvim_command("wincmd p")

    -- Set filetype so custom behavios/settings could be applied.
    api.nvim_buf_set_option(output_buf_nr, "filetype", "output")
end

function M.run(command)
    -- Get a boolean that tells us if the buffer number is visible anymore.
    local buffer_visible = api.nvim_call_function("bufwinnr", { output_buf_nr }) ~= -1

    -- Open/create buffer, if we need to.
    if not buffer_visible then
        create_or_raise_buffer()
    end

    -- Mark output buffer writable
    api.nvim_set_option_value("readonly", false, { buf = output_buf_nr })

    -- Clear the buffer's contents incase it has been used.
    api.nvim_buf_set_lines(output_buf_nr, 0, -1, true, { command })

    -- Run the command.
    fn.jobstart(command .. '&& echo "Done."', {
        stdout_buffered = false,
        on_stdout = Log,
        on_stderr = Log,
    })
end

-- FROM https://stackoverflow.com/questions/75141843/create-a-temporary-readonly-buffer-for-test-output
function Log(_, data)
    if data then
        -- Make it temporarily writable so we don't have warnings.
        api.nvim_set_option_value("readonly", false, { buf = output_buf_nr })

        -- Append the data.
        api.nvim_buf_set_lines(output_buf_nr, -1, -1, true, data)

        -- Make readonly again.
        api.nvim_set_option_value("readonly", true, { buf = output_buf_nr })

        -- Mark as not modified, otherwise you'll get an error when
        -- attempting to exit vim.
        api.nvim_set_option_value("modified", false, { buf = output_buf_nr })

        -- Get the window the buffer is in and set the cursor position to the bottom.
        local buffer_window = api.nvim_call_function("bufwinid", { output_buf_nr })
        local buffer_line_count = api.nvim_buf_line_count(output_buf_nr)
        api.nvim_win_set_cursor(buffer_window, { buffer_line_count, 0 })
    end
end

local function hide_output_window(win_id)
    if #(api.nvim_list_wins()) > 1 then
        api.nvim_win_hide(win_id)
    else
        vim.cmd("b#")
    end
end

local function toggle_output()
    local output_win = api.nvim_call_function("bufwinid", { output_buf_nr })

    if output_win == -1 then
        create_or_raise_buffer()
        return
    end

    hide_output_window(output_win)
end

vim.keymap.set({ "n", "i" }, "<C-S>", toggle_output, { noremap = true })

return M
