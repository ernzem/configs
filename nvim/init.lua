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
    if next(vim.fn.argv()) == nil then
        vim.api.nvim_command('Explore')
    end
end
