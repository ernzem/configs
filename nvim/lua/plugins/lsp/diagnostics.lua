-- Assign new icons for lsp sign column
local function sign_define(args)
    vim.fn.sign_define(args.name, {
        texthl = args.name,
        text = args.text,
        numhl = "",
    })
end

local utils = require("utils")
sign_define({ name = "DiagnosticSignError", text = utils.diagn_symbols.error })
sign_define({ name = "DiagnosticSignWarn", text = utils.diagn_symbols.warn })
sign_define({ name = "DiagnosticSignHint", text = utils.diagn_symbols.hint })
sign_define({ name = "DiagnosticSignInfo", text = utils.diagn_symbols.info })

-- sign_define({ name = "DiagnosticSignError", text = "󰅚" })
-- sign_define({ name = "DiagnosticSignWarn", text = "󰀪" })
-- sign_define({ name = "DiagnosticSignHint", text = "󰌶" })
-- sign_define({ name = "DiagnosticSignInfo", text = "󰋽" })

-- Disable diagnostics when switching mode
-- vim.api.nvim_create_autocmd("ModeChanged", {
--     pattern = { "n:i", "v:s" },
--     desc = "Disable diagnostics in insert and select mode",
--     callback = function(e)
--         vim.diagnostic.enable(false, { bufnr = e.buf })
--     end,
-- })
--
-- -- Enable diagnostics when back to normal
-- vim.api.nvim_create_autocmd("ModeChanged", {
--     pattern = "i:n",
--     desc = "Enable diagnostics when leaving insert mode",
--     callback = function(e)
--         vim.diagnostic.enable(true, { bufnr = e.buf })
--         require("winbar").update()
--     end,
-- })
