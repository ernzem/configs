local go_file = "*.go"
----------------------------CLI Tool Behave Like LSP------------------------------------

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("goFormatting", { clear = false }),
    pattern = go_file,
    callback = function()
        local command = "golangci-lint run ./"
            .. vim.fn.fnamemodify(vim.fn.expand("%:h"), ":p:~:.")
            .. " --fast --out-format json"
        local bufnr = vim.api.nvim_get_current_buf()
        local ns = vim.api.nvim_create_namespace("live-tests")
        local issues = {}

        vim.fn.jobstart(command, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if not data then
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

-------------------------------------------------------------------------------
local utils = require("utils")
vim.api.nvim_create_user_command("AutoTest", function()
    local path = vim.fn.input({
        prompt = "Test Path: ",
        default = "./" .. vim.fn.fnamemodify(vim.fn.expand("%:h"), ":p:~:."),
        completion = "dir",
    })
    local cmd = "go test -failfast -race " .. path

    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("GoAutoTest", { clear = true }),
        pattern = go_file,
        callback = function()
            utils.run(cmd)
        end,
    })

    utils.run(cmd)
end, {})

--------------- Run Tests Functions-----------------------------------------
local function go_package()
    local ui_buffers = require("utils").ui_buffers
    if ui_buffers[vim.bo.filetype] ~= true then
        return "./" .. vim.fn.fnamemodify(vim.fn.expand("%:h"), ":p:~:.")
    end

    local state = require("state").state
    if state["PrevBuffPath"] == nil or vim.fn.fnamemodify(state["PrevBuffPath"], ":e") ~= "go" then
        local input_path = vim.fn.input({
            prompt = "Test Path: ",
            default = "./",
            completion = "dir",
        })
        return input_path
    end

    return "./" .. vim.fn.fnamemodify(state["PrevBuffPath"], ":.:h")
end

local run_package_tests = function()
    utils.run("go test -failfast -race " .. go_package())
end

local run_all_tests = function()
    utils.run("go test -failfast -race ./...")
end
-----------------------------------------------------------------------------

vim.api.nvim_create_user_command("AutoTestStop", function()
    vim.api.nvim_create_augroup("GoAutoTest", { clear = true })
end, {})

vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test)
vim.keymap.set("n", "<leader>dlt", require("dap-go").debug_last_test)

local keyOpts = { noremap = true, silent = true }
vim.keymap.set({ "n", "t" }, "<F6>", run_package_tests, keyOpts)
vim.keymap.set({ "n", "t" }, "<F7>", run_all_tests, keyOpts)

-- vim.keymap.set("n", "<F5>", '<cmd>lua vim.print(Prev_function_name)<cr>', keyOpts) -- TODO: do not run when not test file
-------------treesitter-get-function--------------------------------------------------------
-- local function get_closest_above_cursor(test_tree)
--   local result
--   for _, curr in pairs(test_tree) do
--     if not result then
--       result = curr
--     else
--       local node_row1, _, _, _ = curr.node:range()
--       local result_row1, _, _, _ = result.node:range()
--       if node_row1 > result_row1 then
--         result = curr
--       end
--     end
--   end
--   if result then
--     return format_subtest(result, test_tree)
--   end
--   return nil
-- end
--
-- local function is_parent(dest, source)
--   if not (dest and source) then
--     return false
--   end
--   if dest == source then
--     return false
--   end
--
--   local current = source
--   while current ~= nil do
--     if current == dest then
--       return true
--     end
--
--     current = current:parent()
--   end
--
--   return false
-- end
--
-- local function get_closest_test()
--   local stop_row = vim.api.nvim_win_get_cursor(0)[1]
--   local ft = vim.api.nvim_buf_get_option(0, "filetype")
--   assert(ft == "go", "can only find test in go files, not " .. ft)
--   local parser = vim.treesitter.get_parser(0)
--   local root = (parser:parse()[1]):root()
--
--   local test_tree = {}
--
--   local test_query = vim.treesitter.query.parse(ft, tests_query)
--   assert(test_query, "could not parse test query")
--   for _, match, _ in test_query:iter_matches(root, 0, 0, stop_row) do
--     local test_match = {}
--     for id, node in pairs(match) do
--       local capture = test_query.captures[id]
--       if capture == "testname" then
--         local name = vim.treesitter.get_node_text(node, 0)
--         test_match.name = name
--       end
--       if capture == "parent" then
--         test_match.node = node
--       end
--     end
--     table.insert(test_tree, test_match)
--   end
--
--   local subtest_query = vim.treesitter.query.parse(ft, subtests_query)
--   assert(subtest_query, "could not parse test query")
--   for _, match, _ in subtest_query:iter_matches(root, 0, 0, stop_row) do
--     local test_match = {}
--     for id, node in pairs(match) do
--       local capture = subtest_query.captures[id]
--       if capture == "testname" then
--         local name = vim.treesitter.get_node_text(node, 0)
--         test_match.name = string.gsub(string.gsub(name, " ", "_"), '"', "")
--       end
--       if capture == "parent" then
--         test_match.node = node
--       end
--     end
--     table.insert(test_tree, test_match)
--   end
--
--   table.sort(test_tree, function(a, b)
--     return is_parent(a.node, b.node)
--   end)
--
--   for _, parent in ipairs(test_tree) do
--     for _, child in ipairs(test_tree) do
--       if is_parent(parent.node, child.node) then
--         child.parent = parent.name
--       end
--     end
--   end
--
--   return get_closest_above_cursor(test_tree)
-- end
