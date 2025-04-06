local utils = require("utils")
vim.diagnostic.config({
	virtual_text = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = utils.diagn_symbols.error,
			[vim.diagnostic.severity.WARN] = utils.diagn_symbols.warn,
			[vim.diagnostic.severity.HINT] = utils.diagn_symbols.hint,
			[vim.diagnostic.severity.INFO] = utils.diagn_symbols.info,
		},
	},
})
