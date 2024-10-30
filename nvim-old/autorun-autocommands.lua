local utils = require("utils")

vim.api.nvim_create_user_command("AutoRun", function()
	print("AutoRun starts now...")
	local pattern = vim.fn.input("Pattern: ")
	local cmdRaw = vim.fn.input("Command: ")
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("auto-command", { clear = true }),
		pattern = pattern,
		callback = function()
			utils.run(cmdRaw)
		end,
	})
	utils.run(cmdRaw)
end, {})

vim.api.nvim_create_user_command("AutoStop", function()
	vim.api.nvim_create_augroup("auto-command", { clear = true })
end, {})


vim.api.nvim_create_user_command("AutoTest", function()
    local cmd = vim.fn.input({
        prompt = "Test Path: ",
        default = "go test -failfast -count=1 -race ./" .. vim.fn.fnamemodify(vim.fn.expand("%:h"), ":p:~:."),
        completion = "dir",
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("GoAutoTest", { clear = true }),
        pattern = "*.go",
        callback = function()
            utils.run(cmd)
        end,
    })

    utils.run(cmd)
end, {})

vim.api.nvim_create_user_command("AutoTestStop", function()
    vim.api.nvim_create_augroup("GoAutoTest", { clear = true })
end, {})
