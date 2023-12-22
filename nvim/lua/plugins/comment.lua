local api = require('Comment.api')

vim.keymap.set({'n', 'i'}, '<C-/>', api.toggle.linewise.current)

