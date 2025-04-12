return {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    config = function()
        require("nvim-tree").setup({
            filters = {
                custom = { ".ds_store" },
            },
            git = {
                enable = false,
            },
            view = {
                width = 40,
            },
        })

        vim.keymap.set(
            "n",
            "<leader>te",
            "<cmd>NvimTreeFindFileToggle<cr>",
            { buffer = nil, noremap = true, silent = true, nowait = true }
        )
    end,
}
