local Lazy = {}

function Lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print("Installing lazy.nvim....")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      path,
    })
  end
end

function Lazy.load(p)
  local plugins = p or {}
  Lazy.install(Lazy.path)
  vim.opt.rtp:prepend(Lazy.path)
  require("lazy").setup(plugins, Lazy.opts)
end

Lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
Lazy.opts = {}

Lazy.load({
  -- BASE
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  -- LSP
  "neovim/nvim-lspconfig",
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup()
    end,
  },
  -- FORMATTERS
  "stevearc/conform.nvim",
  -- TELESCOPE
  { "nvim-telescope/telescope.nvim",            lazy = true },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  "nvim-telescope/telescope-ui-select.nvim",
  -- TREESITTER
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  "RRethy/vim-illuminate",
  -- AUTOCOMPLETE
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  -- OIL
  "stevearc/oil.nvim",
  -- YAZI
  "mikavilpas/yazi.nvim",
  -- GIT
  "lewis6991/gitsigns.nvim",
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    }
  },
  -- UI
  "folke/which-key.nvim",
  "ggandor/leap.nvim",
  -- MISC
  "windwp/nvim-autopairs",
  "folke/todo-comments.nvim",
  -- THEME
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "medium",
        ui_contrast = "hard"
      })
    end,
  },
})

require "plugins.lspconfig"
require "plugins.telescope"
require "plugins.which-key"
require "plugins.treesitter"
require "plugins.cmp"
require "plugins.conform"

-- quick setup
require "gitsigns".setup()
require "nvim-autopairs".setup()
require "oil".setup()
require "leap".create_default_mappings()
require "yazi".setup({
  floating_window_scaling_factor = 1
})
require "illuminate".configure()
require "refactoring".setup()
