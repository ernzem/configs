-- https://github.com/echasnovski/mini.pick
return {
	"echasnovski/mini.pick",
	version = false,
	lazy = false,
	config = function()
		local max_width = 100
		local max_height = 8

		local center_float_window = function(size)
			local width = math.floor(vim.o.columns * 0.8)
			local height = math.floor(vim.o.lines * 0.7)

			if size == "small" and width > max_width then
				width = max_width
			end

			if size == "small" and height > max_height then
				height = max_height
			end

			-- Calculate the position to center the window
			local col = math.floor((vim.o.columns - width) / 2)
			local row = math.floor(((vim.o.lines - height) / 2) - 2)

			return { anchor = "NW", height = height, width = width, row = row, col = col }
		end

        local mp = require("mini.pick")
		mp.setup({
			mappings = {
				scroll_down = "<C-d>",
				scroll_left = "<C-h>",
				scroll_right = "<C-l>",
				scroll_up = "<C-u>",
			},
			window = {
				config = center_float_window("small"),
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			mp.builtin.files({ tool = "rg" })
		end, { desc = "Find files" })

		vim.keymap.set("n", "<leader>sg", function()
			mp.builtin.grep({}, { window = { config = center_float_window() } })
		end, { desc = "Search in all files" })

		vim.keymap.set("n", "<leader>sh", function()
			mp.builtin.help({}, { window = { config = center_float_window() } })
		end, { desc = "[S]earch [H]elp" })

		vim.keymap.set("n", "<leader><Tab>", mp.builtin.resume, { desc = "Resume last fuzzy search" })
		vim.keymap.set("n", "<leader>b", mp.builtin.buffers, { desc = "Find existing buffers" })
	end
}
------------------------Autocommands listening ----------------------------------------

-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "MiniPickStart",
-- 	group = vim.api.nvim_create_augroup("MiniPickStartCustom", { clear = true }),
-- 	callback = function()
-- 		local state = mp.get_picker_state()
-- 		local width = math.floor(vim.o.columns * 0.8)
-- 		local height = math.floor(vim.o.lines * 0.8)
--
-- 		-- Calculate the position to center the window
-- 		local col = math.floor((vim.o.columns - width) / 2)
-- 		local row = math.floor((vim.o.lines - height) / 2)
--
-- 		-- Define window configuration
-- 		local win_config = {
-- 			relative = "editor",
-- 			width = width,
-- 			height = height,
-- 			col = col,
-- 			row = row,
-- 			style = "minimal", -- No borders or extra UI elements
-- 			border = "rounded",
-- 		}
--
-- 		-- Create the floating window
-- 		-- vim.print(vim.inspect())
-- 		vim.print(vim.inspect(mp.get_picker_opts()))
-- 		vim.print(vim.inspect(mp.get_picker_state()))
-- 		_ = vim.api.nvim_open_win(0, false, win_config)
-- 		vim.api.nvim_get_current_win()
-- 		-- mp.default_preview()
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "MiniPickMatch",
-- 	group = vim.api.nvim_create_augroup("MiniPickStartCustom", { clear = true }),
-- 	callback = function()
-- 		mp.
-- 	end,
-- })

-------------------------- Floating dock window config:----------------------------------------
-- window = {
-- 	config = function()
-- 		local width = math.floor(vim.o.columns * 0.8)
-- 		local height = math.floor(vim.o.lines * 0.7)
--
--                  if width > 80 then
--                      width = 80
--                  end
--
--                  if height > 5 then
--                      height = 5
--                  end
-- 		-- Calculate the position to center the window
-- 		local col = math.floor((vim.o.columns - width) / 2)
-- 		local row = math.floor((vim.o.lines - height) / 2)
-- 		return { anchor = "NW", height = height, width = width, row = row, col = col }
-- 	end,
--          },

----------------------- bottom full width  window config:---------------------------------

-- window = {
--      config = function()
-- 	        return { anchor = "NW", height = 8, width = vim.o.columns }
--      end,
-- },

------------------------------ Current preview: -----------------------------------------

-- source = {
-- 	preview = function()
-- local width = math.floor(vim.o.columns * 0.9)
-- local height = math.floor(vim.o.lines - 20 * 0.8)
--
-- -- Calculate the position to center the window
-- local col = math.floor((vim.o.columns - width) / 2)
-- local row = math.floor((vim.o.lines - 10 - height) / 2)
--
-- -- Define window configuration
-- local win_config = {
-- 	relative = "editor",
-- 	width = width,
-- 	height = height,
-- 	col = col,
-- 	row = row,
-- 	style = "minimal", -- No borders or extra UI elements
-- 	border = "rounded",
-- }
--
-- local win_id = vim.api.nvim_open_win(0, false, win_config)
-- }, local state = mp.get_picker_state()
-- if state == nil or state == {} or state.windows.target == nil then
-- 	return
-- end
--
-- local matches = mp.get_picker_matches()
-- if matches == nil or matches == {} or matches.current == nil or matches.current == "" then
-- 	return
-- end
--
-- -- local win_id = state.windows.target
-- local buf_id = vim.api.nvim_create_buf(true, false)
-- vim.api.nvim_win_set_buf(win_id, buf_id)
--
-- mp.default_preview(buf_id, matches.current)
-- 	end,
