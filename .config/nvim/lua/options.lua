local options = {
  statuscolumn   = " %s%l%=%r",
  laststatus     = 4,
  breakindent    = true,
  tabstop        = 8,
  softtabstop    = 2,
  shiftwidth     = 2,
  expandtab      = true,
  number         = false,
  relativenumber = true,
  signcolumn     = "yes",
  textwidth      = 80,
  scrolloff      = 10,
  sidescrolloff  = 10,
  winborder      = "single",
  foldenable     = false,
  colorcolumn    = "80",
  smartindent    = true
}

for name, value in pairs(options) do
  vim.opt[name] = value
end
