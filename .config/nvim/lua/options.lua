vim.opt.whichwrap:append "<>[]hl" -- Seemlessly move between lines

local options = {
  statuscolumn   = " %s%l%=%r", -- Custom status column (requires Neovim 0.9+)
  -- laststatus     = 3,              -- Global statusline
  breakindent    = true,
  expandtab      = true, -- Convert tabs to spaces
  softtabstop    = 4,    -- Number of spaces per <Tab> in insert mode
  tabstop        = 4,    -- Number of spaces that a <Tab> in the file counts for
  shiftwidth     = 2,    -- Number of spaces for each indentation
  hlsearch       = false,
  ignorecase     = true,
  smartcase      = true, -- Override ignorecase if search contains capitals
  number         = false,
  relativenumber = true,
  signcolumn     = "yes",
  textwidth      = 80,
  scrolloff      = 10,
  sidescrolloff  = 10,
  winborder      = "single",
  foldenable     = false,
  -- colorcolumn    = "80",

  smartindent    = true,
  -- fillchars      = {     -- Customize fill characters
  --   eob       = " ",     -- Empty buffer lines
  --   fold      = " ",
  --   foldopen  = "",
  --   foldsep   = " ",
  --   foldclose = "",
  --   lastline  = " ",
  -- },
}

for name, value in pairs(options) do
  vim.opt[name] = value
end
