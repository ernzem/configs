require("defaults")
require("keymaps")

if not vim.g.vscode then
    require("plugin_manager")
    require("commands")
    require("state")
    require("winbar")
    require("statusline")
    require("terminal")

    -- vim.cmd("colorscheme github_light_high_contrast")
    vim.cmd("colorscheme kanagawa-wave")
end
