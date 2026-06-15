vim.g.mapleader = " "

vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1.*"),
    },

    "https://github.com/stevearc/conform.nvim",
    "https://github.com/echasnovski/mini.cursorword",
    "https://github.com/sainnhe/everforest",
    "https://github.com/tpope/vim-fugitive",

    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-tree/nvim-web-devicons",

    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/nvim-mini/mini.files",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/tpope/vim-surround",
})

require("vim._core.ui2").enable()
vim.cmd("packadd nvim.undotree")

require("options")
require("theme")
require("autocmd")
require("lsp")
require("keymap")

