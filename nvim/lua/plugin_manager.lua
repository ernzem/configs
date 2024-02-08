-- Install package manager: https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
    ----------------Colorschemes------------------------------
    { 'projekt0n/github-nvim-theme' },
    -- { "ramojus/mellifluous.nvim",   priority = 1000 },
    { 'rebelot/kanagawa.nvim' },
    -- {
    --     "briones-gabriel/darcula-solid.nvim",
    --     dependencies = "rktjmp/lush.nvim",
    --     priority = 1000,
    -- },
    -------------------GIT-------------------------------------
    -- Show, view git changes
    { 'lewis6991/gitsigns.nvim' },
    -- Git commands in vim
    -- { 'tpope/vim-fugitive' },
    -- Git open files in github
    -- { 'tpope/vim-rhubarb' },
    -----------------Telescope----------------------------------
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    --------------Treesitter (syntax parser)--------------------
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    ---------------------------LSP------------------------------
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            -- Additional lua configuration
            { 'folke/neodev.nvim',       opts = {} }
        },
    },
    ---------------------Autocompletion----------------------------
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        }
    },

    ----------------------Others----------------------------------
    -- Statusline
    { 'nvim-lualine/lualine.nvim' },
    -- Tag files and access allways via hotkeys
    { 'ThePrimeagen/harpoon' },
    -- Visualize undo tree
    { 'mbbill/undotree' },
    -- Comment single line or block of lines with hotkeys
    { 'numToStr/Comment.nvim',       lazy = true,   opts = {} },
    -- Toggle terminal functionality
    { 'akinsho/toggleterm.nvim',     version = "*", config = true },
    -- Dev icons
    { 'nvim-tree/nvim-web-devicons', opts = {} },
    -- File Browser: https://github.com/nvim-tree/nvim-tree.lua
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = true,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        }
    },
    -- Sync terminal background with vim background
    { "typicode/bg.nvim", lazy = false },
    ------------------------Debugger-------------------------------
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- Creates a beautiful debugger UI
            'rcarriga/nvim-dap-ui',
            -- Debugger configs for go
            'leoluz/nvim-dap-go',
        }
    }
})

-- Import Settings
require("plugins.treesitter")
require("plugins.colorscheme")
require("plugins.nvim-tree")
require("plugins.statusline")
require("plugins.telescope")
require("plugins.gitsigns")
require("plugins.undotree")
require("plugins.harpoon")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.dap")
require("plugins.toggleterm")
require("plugins.comment")
require("plugins.luasnip")
