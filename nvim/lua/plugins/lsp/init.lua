return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { { path = "luvit-meta/library", words = { "vim%.uv" } } } },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    require("plugins.lsp.keymaps").set_keymaps(event)

                    -- Highlight references of the var under the cursor if no mouse movement
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            local servers = require("plugins.lsp.servers")
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            require("mason").setup()

            require("mason-tool-installer").setup({
                ensure_installed = vim.list_extend(vim.tbl_keys(servers or {}), require("plugins.lsp.tools")),
            })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })

            -- Set LSP Diagnostics settings
            require("plugins.lsp.diagnostics")
        end,
    },
}
