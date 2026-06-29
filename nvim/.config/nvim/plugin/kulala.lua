require("kulala").setup({
    global_keymaps = false,
    kulala_keymaps = {
        ["Previous tab"] = false,
        ["Next tab"] = false,
    },
})

local k = require("kulala")
vim.keymap.set("n", "<leader>Rs", k.run, { desc = "Send request" })
vim.keymap.set("n", "<leader>Ra", k.run_all, { desc = "Send all requests" })
vim.keymap.set("n", "<leader>Rb", k.scratchpad, { desc = "Open scratchpad" })
