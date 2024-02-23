if vim.g.vscode then
    require("defaults")
    require("keymaps")
else
    require("defaults")
    require("keymaps")
    require("commands")
    require("plugin_manager")
    require("state")
end
