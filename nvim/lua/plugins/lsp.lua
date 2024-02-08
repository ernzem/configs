-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    local telescope = require('telescope.builtin')
    local vertical_layout = { layout_strategy = 'vertical', layout_config = { preview_cutoff = 60 }, fname_width = 100, results_title = nil }
    local ivy_theme = require('telescope.themes').get_ivy({ previewer = false, layout_config = { height = 10 }, fname_width = 100 })

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

    nmap('gr', function() telescope.lsp_references(ivy_theme) end, '[G]oto [R]eferences')
    nmap('gI', function() telescope.lsp_implementations(ivy_theme) end, '[G]oto [I]mplementation')

    nmap('Gr', function() telescope.lsp_references(vertical_layout) end, '[G]oto [R]eferences')
    nmap('<leader>I', function() telescope.lsp_implementations(vertical_layout) end, '[G]oto [I]mplementation')

    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
    nmap('<C-f>', vim.lsp.buf.format, 'Format current buffer with LSP')
    vim.keymap.set('i', '<C-f>', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format current buffer with LSP' })
    vim.keymap.set('n', '<leader>er', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
        { noremap = true, silent = true })
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

-- Setup neovim lua configuration to enable type checking for nvim-dap-ui to get type checking, documentation and autocompletion for all API functions.
require('neodev').setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}
