if vim.g.vscode then
    require("core.core")
    require("core.keymaps")
else
    --  require("")
    require("core.core")
    require("core.keymaps")
    require("core.autocommands")
    require("plugins")
    require("lang")
    -- Single statusline always
    vim.opt.laststatus = 3
end
