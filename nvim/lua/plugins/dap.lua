local dap, dapui, dapgo = require("dap"), require("dapui"), require('dap-go')
dapgo.setup()

dapui.setup({
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    element_mappings = {},
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    force_buffers = true,
    layouts = {
        {
            -- You can change the order of elements in the sidebar
            elements = {
                -- Provide IDs as strings or tables with "id" and "size" keys
                {
                    id = "breakpoints",
                    size = 0.10
                },
                {
                    id = "stacks",
                    size = 0.20
                },
                {
                    id = "watches",
                    size = 0.20
                },
                {
                    id = "scopes",
                    size = 0.50, -- Can be float or integer > 1
                },
            },
            size = 65,
            position = "left", -- Can be "left" or "right"
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 10,
            position = "bottom", -- Can be "bottom" or "top"
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
            ["close"] = { "q", "<Esc>" },
        },
    },
    controls = {
        enabled = vim.fn.exists("+winbar") == 0,
        element = "repl",
        icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
        },
    },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
        indent = 1,
    },
})

-- Open automatically when a new debug session is created
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Keymaps
vim.keymap.set('n', '<F4>', dapui.toggle)
vim.keymap.set('n', '<F8>', dap.continue)
vim.keymap.set('n', '<F9>', dap.step_over)
vim.keymap.set('n', '<F10>', dap.step_into)
vim.keymap.set('n', '<F11>', dap.step_out)
vim.keymap.set('n', '<F12>', dap.terminate)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>e', dapui.eval)

-- Auto run debugger
vim.api.nvim_create_user_command("AutoDebug", function()
    dap.terminate()
    dap.continue()
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("DAP", { clear = true }),
        pattern = "*.go",
        callback = function()
            dap.run_last()
        end,
    })
end, {})


vim.api.nvim_create_user_command("AutoDebugStop", function()
    vim.api.nvim_create_augroup("DAP", { clear = true })
end, {})
