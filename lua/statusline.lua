--[[ :h "statusline'
This is default statusline value:

```lua
vim.o.statusline = "%f %h%w%m%r%=%-14.(%l,%c%V%) %P"
```

See `:h "statusline'` for more information about statusline.
]]

---@return string
local function lsp_attached()
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #attached_clients == 0 then
    return "no lsp attached"
  end
  local names = vim.iter(attached_clients)
  :map(function(client)
    local name = client.name:gsub("language.server", "ls")
    return name
  end)
  :totable()
  return table.concat(names, ", ")
end

---@return string
local function lsp_status()
  local diagnostics = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  local function display(type, count, separator)
    local sep = separator or " | "
    return type .. ": " .. count .. sep
  end
  local is_any_issues = diagnostics + warnings + hints + infos
  if is_any_issues == 0 then
    return ":)"
  end
  return display("E", diagnostics) .. display("W", warnings) .. display("H", hints) .. display("I", infos, " ")
end

function _G.statusline()
  return table.concat({
    "%#Statusline#",
    " ",
    lsp_status(),
    "%=",
    "%t",
    "%h%w%m%r",
    "%=",
    lsp_attached(),
    " ",
    "%l,%c",
    "%P",
    " ",
  }, " ")
end

local bg_status = "#343B4B"

vim.o.statusline = "%{%v:lua._G.statusline()%}"

vim.api.nvim_set_hl(0, "Statusline", { fg = "#E5E9F0", bg = bg_status })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  pattern = "*",
  callback = lsp_status,
})
