local M = {}

M.set_keymaps = function(event)
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
	end

	map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	map("K", vim.lsp.buf.hover, "Hover Documentation")
	map("<leader>de", vim.diagnostic.open_float, "Show [D]iagnostic error [M]essages")
end

return M
