return {
	"akinsho/bufferline.nvim",
	enabled = false,
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "BufWinEnter",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				style_preset = bufferline.style_preset.no_italic,
				numbers = "ordinal",
				diagnostics = "nvim_lsp",
				indicator = {
					style = "none",
				},
				custom_areas = {
					right = function()
						local result = {}
						local seve = vim.diagnostic.severity
						local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
						local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
						local info = #vim.diagnostic.get(0, { severity = seve.INFO })
						local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

						if error ~= 0 then
							table.insert(result, { text = " E " .. error, link = "DiagnosticError" })
						end

						if warning ~= 0 then
							table.insert(result, { text = " W " .. warning, link = "DiagnosticWarn" })
						end

						if hint ~= 0 then
							table.insert(result, { text = " H " .. hint, link = "DiagnosticHint" })
						end

						if info ~= 0 then
							table.insert(result, { text = " I " .. info, link = "DiagnosticInfo" })
						end
						return result
					end,
				},
			},
		})

		vim.keymap.set({ "n", "i" }, "<leader>m", "<cmd>BufferLineTogglePin<cr>", { noremap = true, silent = true })

		vim.keymap.set({ "n", "i" }, "<C-1>", "<cmd>BufferLineGoToBuffer 1<cr>", { noremap = true, silent = true })
		vim.keymap.set({ "n", "i" }, "<C-2>", "<cmd>BufferLineGoToBuffer 2<cr>", { noremap = true, silent = true })
		vim.keymap.set({ "n", "i" }, "<C-3>", "<cmd>BufferLineGoToBuffer 3<cr>", { noremap = true, silent = true })
		vim.keymap.set({ "n", "i" }, "<C-4>", "<cmd>BufferLineGoToBuffer 4<cr>", { noremap = true, silent = true })
	end,
}
