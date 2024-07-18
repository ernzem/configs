return {
    gopls = {
        analyses = {
            unusedparams = true,
        },
        gofumpt = true,
        staticcheck = true,
    },
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    },
}
