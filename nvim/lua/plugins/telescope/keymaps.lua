local t = require("telescope.builtin")

local vertical_layout = {
    layout_strategy = "vertical",
    layout_config = { preview_cutoff = 60 },
    fname_width = 100,
    results_title = nil,
}

local ivy_theme = require("telescope.themes").get_ivy({
    previewer = false,
    layout_config = { height = 20 },
    show_line = false, -- telescope lsp_implementations specific config
})

-- Search

vim.keymap.set("n", "<leader>f", t.find_files, { desc = "Search [F]iles" })
vim.keymap.set("n", "<leader>gf", t.git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>?", t.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>sh", t.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>b", t.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sw", t.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", t.live_grep, { desc = "[S]earch by [G]rep" })

-- LSP

vim.keymap.set("n", "<leader>sd", t.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "gr", function() t.lsp_references(ivy_theme) end, { desc = "[G]oto [R]eferences" })

-- vim.keymap.set("n", "gI", function() telescope.lsp_implementations(ivy_theme) end, { desc = "[G]oto [I]mplementation" })

vim.keymap.set("n", "Gr", function() t.lsp_references(vertical_layout) end, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "<leader>I", function() t.lsp_implementations(vertical_layout) end,
    { desc = "[G]oto [I]mplementation" })

-- Open config  files

vim.keymap.set("n", "<leader>sn", function() t.find_files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "[S]earch [N]eovim files" })

vim.keymap.set("n", "<leader>sc", function() t.find_files({ cwd = "~/.cfg" }) end,
    { desc = "[S]earch [C]onfiguration files" })
