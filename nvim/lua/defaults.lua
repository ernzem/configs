-- Disable Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set relative line number
vim.opt.nu = true
-- vim.opt.relativenumber = true

-- Remove "~" from empty lines
vim.opt.fillchars = { eob = " "}

-- Enable mouse mode
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Code folding options
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Autoread file changes on the disk
vim.o.autoread = true

-- Indenting
vim.opt.breakindent = true
vim.opt.smartindent = true

-- Not use swapfiles & backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

--Use increment (regex) search
vim.opt.incsearch = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- When scrolling keep at least nr of lines at the bottom
vim.opt.scrolloff = 10

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noinsert" }

-- Default tab behavior
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Highlight number
vim.opt.cursorline = true

-- Open new split panes to right and bottom, which feels more natural
vim.o.splitbelow = true
vim.o.splitright = true

-- Statusline
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.showmode = false

-- Title in titlebar work-dir nvim
vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
vim.opt.titlestring = "%{fnamemodify(getcwd(0), ':t')}"
