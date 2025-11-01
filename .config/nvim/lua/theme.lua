vim.cmd [[colorscheme tokyonight-moon]]

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = "#444a73", bold = true })
vim.api.nvim_set_hl(0, 'LineNr', { fg = "#ff757f", bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = "#444a73", bold = true })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = "#c3e88d", bg = 'NONE' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = "#ffc777", bg = 'NONE' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = "#ff757f", bg = 'NONE' })
vim.api.nvim_set_hl(0, 'GitSignsTopDelete', { fg = "#ff966c", bg = 'NONE' })
vim.api.nvim_set_hl(0, 'GitSignsChangeDelete', { fg = "#ff966c", bg = 'NONE' })
vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = "#82aaff", bg = 'NONE' })

vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', { fg = "#ff9e64" })
vim.api.nvim_set_hl(0, 'MiniCursorword', { fg = "#ff9e64" })

vim.api.nvim_set_hl(0, 'ColorColumn', { bg = "#292e42" })
