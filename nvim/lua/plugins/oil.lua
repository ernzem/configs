-- https://github.com/stevearc/oil.nvim
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            columns = { "icon" },
            view_options = { show_hidden = true },
            keymaps = {
                ["<Bs>"] = "actions.parent",
            },
        })
        vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>Oil<cr>", {})
    end,
}
