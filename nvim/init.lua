require("defaults")
require("keymaps")

if not vim.g.vscode then
    require("plugin_manager")
    require("commands")
    require("winbar")
    require("output_buffer")
    require("statusline")
    require("colors")

    -- vim.cmd("colorscheme github_dark")
    -- vim.cmd("colorscheme github_light_high_contrast")
    -- vim.cmd("colorscheme kanagawa-wave")
end
