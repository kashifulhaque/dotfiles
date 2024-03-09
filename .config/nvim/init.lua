vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Set leader key to spacebar
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  }
}
local opts = {}

-- Lazy.nvim to load plugins
require("lazy").setup(plugins, opts)

-- Use Telescope for searching files and searching something across files
local builtin = require("telescope.builtin")

-- Ctrl + p to find files using fuzzy matching
vim.keymap.set("n", "<C-p>", builtin.find_files, {})

-- Ctrl + f to live grep through files (Search for some code across files)
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})

-- Treesitter config
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = { "awk", "bash", "c", "cpp", "css", "csv", "dockerfile", "lua", "vim", "vimdoc", "go", "java", "javascript", "jsdoc", "json", "html", "latex", "nix", "python", "rust", "sql", "tsv", "typescript", "typst", "vue", "yaml" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Modified version of catppuccin mocha
require("catppuccin").setup({
  color_overrides = {
    mocha = {
      base = "#181818",
      mantle = "#181818",
      crust = "#181818",
    },
  },
})
vim.cmd.colorscheme "catppuccin"
