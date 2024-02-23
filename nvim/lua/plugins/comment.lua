return {
    'numToStr/Comment.nvim',
    lazy = true,
    config = function()
        local api = require('Comment.api')
        vim.keymap.set({ 'n', 'i' }, '<C-/>', api.toggle.linewise.current)
    end
}
