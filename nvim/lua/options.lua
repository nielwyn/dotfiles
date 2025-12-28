local options = {
  number         = false,
  relativenumber = true,
  signcolumn     = "yes",
  colorcolumn    = "80",
  statuscolumn   = " %s%l%=%r",
  laststatus     = 4,
  scrolloff      = 10,
  sidescrolloff  = 10,
  winborder      = "single",
  hlsearch       = false,
  breakindent    = true,
  smartindent    = true,
  tabstop        = 8,
  softtabstop    = 2,
  shiftwidth     = 2,
  expandtab      = true,
  textwidth      = 80,
  foldenable     = false,
}

for name, value in pairs(options) do
  vim.opt[name] = value
end
