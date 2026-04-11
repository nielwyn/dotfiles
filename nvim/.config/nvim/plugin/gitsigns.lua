local gitsigns = require("gitsigns")

gitsigns.setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "X" },
        changedelete = { text = "±" },
        untracked = { text = "?" },
    },
    signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "X" },
        changedelete = { text = "±" },
        untracked = { text = "?" },
    },
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 100,
    },
})

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#a7c080", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#dbbc7f", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e67e80", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsTopDelete", { fg = "#e69875", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { fg = "#e69875", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#7fbbb3", bg = "NONE" })

local map = vim.keymap.set
map("n", "]c", function()
    if vim.wo.diff then
        return "]c"
    end
    vim.schedule(function()
        gitsigns.nav_hunk("next")
    end)
    return "<Ignore>"
end, { expr = true })
map("n", "[c", function()
    if vim.wo.diff then
        return "[c"
    end
    vim.schedule(function()
        gitsigns.nav_hunk("prev")
    end)
    return "<Ignore>"
end, { expr = true })
map("n", "<leader>hr", gitsigns.reset_hunk)
map("n", "<leader>hp", gitsigns.preview_hunk)
map("v", "<leader>hr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end)
