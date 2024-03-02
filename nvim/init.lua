require("defaults")
require("keymaps")

if not vim.g.vscode then
    require("commands")
    require("state")
    require("plugin_manager")

    vim.cmd("colorscheme kanagawa-wave")
end
