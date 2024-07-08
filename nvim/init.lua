require("defaults")
require("keymaps")

if not vim.g.vscode then
    require("plugin_manager")
    require("commands")
    require("output_buffer")
    require("statusline")
    require("winbar")

    -- vim.cmd("colorscheme kanagawa-wave")
    vim.cmd("colorscheme catppuccin-macchiato")
end
