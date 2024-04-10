local options = {
    hide_nc_statusline = false, -- Override the underline style for non-active statuslines
    terminal_colors = true,
    dim_inactive = true,
}

local palettes = {
    github_light_high_contrast = {
        red = "#780021", -- not working at the moment
    },
}

local specs = {
    github_light_high_contrast = {
        inactive = "#eeeeee",
    },
}

local groups = {
    github_light_high_contrast = {
        NormalNC = { bg = "inactive" }, -- Non-current windows
        StatusLine = { bg = "inactive" },
    },
}

return {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
        require("github-theme").setup({
            options = options,
            palettes = palettes,
            specs = specs,
            groups = groups,
        })
    end,
}
