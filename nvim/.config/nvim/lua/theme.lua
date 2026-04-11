vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.g.everforest_background = "medium"
vim.g.everforest_better_performance = 1
vim.g.everforest_transparent_background = 1
vim.cmd.colorscheme("everforest")

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7a8478", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#e67e80", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#7a8478", bold = true })

vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3d484d" })
