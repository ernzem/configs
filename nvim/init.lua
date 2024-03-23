require("defaults")
require("keymaps")

if not vim.g.vscode then
    require("colors")
    require("plugin_manager")
    require("commands")
    require("state")
    require("winbar")
    require("statusline")
    require("terminal")
end
