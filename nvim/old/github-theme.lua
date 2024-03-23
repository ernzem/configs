local options = {
    hide_nc_statusline = false, -- Override the underline style for non-active statuslines
    terminal_colors = false,
    dim_inactive = true,
}

local palletes = {
    all = {
        bg1 = "#ed8115",
    },
}

local specs = {
    github_light_high_contrast = {
        string = "#443322",
    },
}

return {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("github-theme").setup({
            options = options,
            palletes = palletes,
        })
    end,
}
