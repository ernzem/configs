-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set relative line number
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Autoread file changes on the disk
vim.o.autoread = true

-- Indenting
vim.opt.breakindent = true
vim.opt.smartindent = true

-- Use swapfiles & backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Don't keep search results highlighted & use increment (regex) search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- When scrolling keep at least nr of lines at the bottom
vim.opt.scrolloff = 10

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Default tab behavior
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set command line to autohide when not in use
-- vim.opt.cmdheight = 0

-- Highlight number
vim.opt.cursorline = true

-- Netrw (File Explorer settings)
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = '^..=/=$,.DS_Store,.idea,__pycache__,venv,*.o,*.pyc,.*.swp'
vim.g.netrw_hide = 1
vim.g.netw_browse_split = 4
vim.g.netrw_altv = 1
-- vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20

-- Open new split panes to right and bottom, which feels more natural
vim.o.splitbelow = true
vim.o.splitright = true
