return {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
        require('Comment').setup()
        local api = require('Comment.api')
        vim.keymap.set({ 'n', 'i' }, '<C-/>', api.toggle.linewise.current)
    end
}
