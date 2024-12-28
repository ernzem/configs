return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git_branch",
        icons = true,
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
        { "<leader>m", "<cmd>Grapple toggle<cr>",         desc = "Grapple toggle tag",       silent = true },
        { "<leader>`", "<cmd>Grapple toggle_tags<cr>",    desc = "Grapple open tags window", silent = true },

        { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Select first tag",         silent = true },
        { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Select second tag",        silent = true },
        { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Select third tag",         silent = true },
        { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag",        silent = true },
        { "<leader>5", "<cmd>Grapple select index=5<cr>", desc = "Select fourth tag",        silent = true },
        { "<leader>6", "<cmd>Grapple select index=6<cr>", desc = "Select fourth tag",        silent = true },
    },
}
