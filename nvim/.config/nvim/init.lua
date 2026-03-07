require("config.lazy")
require("options")
require("keymap")
require("theme")
require("autocmd")

-- Persistent undotree
if vim.fn.has("persistent_undo") then
  local target_path = vim.fn.expand('~/.undodir')
  -- create the directory and any parent directories
  if vim.fn.isdirectory(target_path) == 0 then
    vim.fn.mkdir(target_path, "p", '0o700')
  end
  vim.opt.undodir = target_path
  vim.opt.undofile = true
end
