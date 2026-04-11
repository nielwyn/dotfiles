require("trouble").setup()

vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "NONE", })
vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "NONE" })

local map = vim.keymap.set
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>")
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>")
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>")
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>")
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>")
