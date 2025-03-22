local wk = require 'which-key'

wk.setup({
  preset = 'helix',
  win = {
    padding = { 1, 3 },
    wo = {
      winblend = 0,
    },
  }
})

vim.api.nvim_set_hl(0, "WhichKeyNormal", {bg = "#2E3440"})
vim.api.nvim_set_hl(0, "WhichKeyBorder", {bg = "#2E3440"})

