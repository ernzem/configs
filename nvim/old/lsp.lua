return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        { "folke/neodev.nvim",       opts = {} },
    },
    config = function()
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

            nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

            nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
            nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

            -- See `:help K` for why this keymap
            nmap("K", vim.lsp.buf.hover, "Hover Documentation")
            nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

            -- Diagnostic keymaps
            vim.keymap.set(
                "n",
                "<leader>db",
                vim.diagnostic.goto_prev,
                { desc = "Go to previous [D]iagnostic message" }
            )
            vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
            vim.keymap.set(
                "n",
                "<leader>de",
                vim.diagnostic.open_float,
                { desc = "Show [D]iagnostic error [M]essages" }
            )
            vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic [Q]uickfix list" })

            -- Lesser used LSP functionality
            nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            -- TODO: Disabled because unused and collides with save keyword
            -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            -- nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            --     '[W]orkspace [L]ist Folders')
        end

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. They will be passed to
        --  the `settings` field of the server config. You must look up that documentation yourself.
        --
        --  If you want to override the default filetypes that your language server will attach to you can
        --  define the property 'filetypes' to the map in question.
        local servers = {
            -- clangd = {},
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                hoverKind = "FullDocumentation",
                linkTarget = "pkg.go.dev",
                vulncheck = "Imports",
                analyses = {
                    assign = true,
                    atomic = true,
                    bools = true,
                    composites = true,
                    copylocks = true,
                    deepequalerrors = true,
                    embed = true,
                    errorsas = true,
                    fieldalignment = true,
                    httpresponse = true,
                    ifaceassert = true,
                    loopclosure = true,
                    lostcancel = true,
                    nilfunc = true,
                    nilness = true,
                    nonewvars = true,
                    printf = true,
                    shadow = true,
                    shift = true,
                    simplifycompositelit = true,
                    simplifyrange = true,
                    simplifyslice = true,
                    sortslice = true,
                    stdmethods = true,
                    stringintconv = true,
                    structtag = true,
                    testinggoroutine = true,
                    tests = true,
                    timeformat = true,
                    unmarshal = true,
                    unreachable = true,
                    unsafeptr = true,
                    unusedparams = true,
                    unusedresult = true,
                    unusedvariable = true,
                    unusedwrite = true,
                    useany = true,
                },
            },
            -- golangci_lint_ls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- tsserver = {},
            -- html = { filetypes = { 'html', 'twig', 'hbs'} },
            -- eslint = {
            --     enable = true,
            --     format = { enable = true }, -- this will enable formatting
            --     autoFixOnSave = true,
            --     codeActionsOnSave = {
            --         mode = "all",
            --         rules = { "!debugger", "!no-only-tests/*" },
            --     },
            --     lintTask = {
            --         enable = true,
            --     },
            -- },

            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        -- Assign new icons for lsp sign column
        local function sign_define(args)
            vim.fn.sign_define(args.name, {
                texthl = args.name,
                text = args.text,
                numhl = "",
            })
        end
        sign_define({ name = "DiagnosticSignError", text = "" })
        sign_define({ name = "DiagnosticSignWarn", text = "" })
        sign_define({ name = "DiagnosticSignHint", text = "󰌶" })
        sign_define({ name = "DiagnosticSignInfo", text = "󰋽" })

        -- Disable diagnostics when switching mode
        vim.api.nvim_create_autocmd("ModeChanged", {
            pattern = { "n:i", "v:s" },
            desc = "Disable diagnostics in insert and select mode",
            callback = function(e)
                vim.diagnostic.disable(e.buf)
            end,
        })

        -- Enable diagnostics when back to normal
        vim.api.nvim_create_autocmd("ModeChanged", {
            pattern = "i:n",
            desc = "Enable diagnostics when leaving insert mode",
            callback = function(e)
                vim.diagnostic.enable(e.buf)
                require("winbar").update()
            end,
        })

        -- TODO: fix the following 2 autocmds from kickstart.nvim . It should highlight all same variables

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client and client.server_capabilities.documentHighlightProvider then
        --     vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        --         buffer = event.buf,
        --         callback = vim.lsp.buf.document_highlight,
        --     })
        --
        --     vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        --         buffer = event.buf,
        --         callback = vim.lsp.buf.clear_references,
        --     })
        -- end

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
        })

        mason_lspconfig.setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                })
            end,
        })
    end,
}
