-- Auto-clear Copilot suggestion when leaving insert mode
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "i:*",
  callback = function()
    vim.fn["copilot#Clear"]()
  end,
  desc = "Clear Copilot suggestion on leaving insert mode",
})
