return {
	"nvim-mini/mini.files",
	enabled = false,
	lazy = false,
	version = false,
	config = function()
		local mn = require("mini.files")
		mn.setup({
			mappings = {
				go_in_plus = "<CR>",
			},
		})
		-- KEYMAPS
		vim.keymap.set("n", "<leader>e", function()
			local buf_name = vim.api.nvim_buf_get_name(0)
			local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
			mn.open(path)
			mn.reveal_cwd()
		end, { desc = "Toggle mini.files" })

		vim.keymap.set("n", "<ESC>", function()
			mn.close()
		end, { desc = "Close mini.files" })
	end,
}
