vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffffff' })

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:n",
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff" })
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:i",
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#A3BE8C" })
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:v",
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#B988B0" })
  end,
})

