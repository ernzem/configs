if vim.g.vscode then
	return
end

local go_file = "*.go"
-----------------------------Auto add/remove/organize imports before save------------------------

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = go_file,
	callback = function()
		local params = vim.lsp.util.make_range_params()

		local timeout = 1000 -- milliseconds
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout)

		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end,
})

----------------------------Golangci lint ru on save lsp diagnostics ------------------------------------

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("goFormatting", { clear = false }),
	pattern = go_file,
	callback = function()
		local command = "golangci-lint run ./"
			.. vim.fn.fnamemodify(vim.fn.expand("%:h"), ":p:~:.")
			.. " --fast --fix --out-format json"
		local bufnr = vim.api.nvim_get_current_buf()
		local ns = vim.api.nvim_create_namespace("live-tests")
		local issues = {}

		vim.fn.jobstart(command, {
			stdout_buffered = true,
			on_stdout = function(_, data)
				if not data then
					return
				end

				-- Return if data is empty string
				local len = #data
				if len == 1 and data[len] == "" then
					return
				end

				for _, line in ipairs(data) do
					if line == "" then
						goto continue
					end
					local decoded = vim.json.decode(line)
					for _, issue in pairs(decoded.Issues) do
						table.insert(issues, issue)
					end
					::continue::
				end
			end,

			on_exit = function()
				-- Reload current buffer
				vim.cmd("if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif")

				-- Add issues to table
				local failed = {}
				for _, issue in pairs(issues) do
					local issueFileRelPath = vim.loop.cwd() .. "/" .. issue.Pos.Filename
					if issueFileRelPath == vim.api.nvim_buf_get_name(0) then
						table.insert(failed, {
							bufnr = bufnr,
							lnum = issue.Pos.Line - 1,
							col = issue.Pos.Column - 1,
							severity = vim.diagnostic.severity.ERROR,
							source = issue.FromLinter,
							message = issue.FromLinter .. ": " .. issue.Text,
							user_data = {},
						})
					end
				end

				vim.diagnostic.set(ns, bufnr, failed, {})
			end,
		})
	end,
})

-----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test)
vim.keymap.set("n", "<leader>dlt", require("dap-go").debug_last_test)

-- local keyOpts = { noremap = true, silent = true }
-- vim.keymap.set({ "n", "t" }, "<F6>", run_package_tests, keyOpts)
-- vim.keymap.set({ "n", "t" }, "<F7>", run_all_tests, keyOpts)

--------------- Run Tests Functions-----------------------------------------
-- local utils = require("utils")
-- local function go_package()
--     if require("utils").is_ui_filetype(vim.bo.filetype) ~= true then
--         return "./" .. vim.fn.fnamemodify(vim.fn.expand("%:h"), ":p:~:.")
--     end
--
--     local state = require("state").state
--     if state["PrevBuffPath"] == nil or vim.fn.fnamemodify(state["PrevBuffPath"], ":e") ~= "go" then
--         local input_path = vim.fn.input({
--             prompt = "Test Path: ",
--             default = "./",
--             completion = "dir",
--         })
--         return input_path
--     end
--
--     return "./" .. vim.fn.fnamemodify(state["PrevBuffPath"], ":.:h")
-- end

-- local run_package_tests = function()
--     utils.run("go test -failfast -count=1 -race " .. go_package())
-- end
--
-- local run_all_tests = function()
--     utils.run("go test -failfast -count=1 -race ./...")
-- end
