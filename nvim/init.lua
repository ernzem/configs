require("defaults")
require("keymaps")

if not vim.g.vscode then
    require("plugin_manager")
    require("commands")
    require("output_buffer")
    require("statusline")
    require("winbar")
    -- require("colors")

    -- vim.cmd("colorscheme github_light_high_contrast")
    vim.cmd("colorscheme kanagawa-wave")
end
