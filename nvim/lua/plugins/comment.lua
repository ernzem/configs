local api = require('Comment.api')

vim.keymap.set({'n', 'i'}, '<C-_>', api.toggle.linewise.current)

