return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup(
                    {
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
                            { text = { "%s" },                  click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }
                        }
                    }
                )
            end

        }
    },
    event = "BufReadPost",
    config = function()
        require('ufo').setup({
            provider_selector = function()
                return { 'treesitter', 'indent' }
            end
        })

        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        vim.keymap.set('n', 'zp', function()
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end)
    end
}
