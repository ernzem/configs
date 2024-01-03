-- https://github.com/akinsho/toggleterm.nvim/tree/main
require("toggleterm").setup({
    size = 20,
    open_mapping = [[<c-a>]],
    hide_numbers = true,
    shade_terminals = false,  -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    shading_factor = 2,       -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
    start_in_insert = true,
    insert_mappings = true,   -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    winbar = {
        enabled = false,
    }
})
----------------------------Change Terminal Placement-----------------------------
local direction = { "horizontal", "vertical", "float" }
local choice = 1
vim.api.nvim_create_user_command("SwitchTermMode", function()
    choice = choice + 1
    if #direction < choice then
        choice = 1
    end

    vim.cmd("ToggleTerm direction=" .. direction[choice])
end, {})

--------------------------Lazygit------------------------------------------------
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

local function lazygit_toggle()
    lazygit:toggle()
end

vim.keymap.set("n", [[<leader>\]], lazygit_toggle, { noremap = true, silent = true })
vim.keymap.set({ "i", "t" }, [[<c-a>]], '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
