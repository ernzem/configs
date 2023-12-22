if vim.g.vscode then
    require("core.core")
    require("core.keymaps")
else
    --  require("")
    require("core.core")
    require("core.winbar")
    require("core.keymaps")
    require("core.autocommands")
    require("plugins")
    require("lang")
end
