local map = vim.keymap.set

map({ "n", "v" }, "y", '"+y')
map({ "n", "v" }, "x", '"_x') -- Delete without yanking

map("n", "Y", '"+Y')
map("n", "y", '"+y')

map("v", "<C-j>", ":m '>+1<CR>gv")
map("v", "<C-k>", ":m '<-2<CR>gv")

map("n", "<leader>u", "<cmd>Undotree<cr>")

local lsp = vim.lsp.buf
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }
        map("n", "K", lsp.hover, opts)
        map("n", "gd", lsp.definition, opts)
        map("n", "gD", lsp.declaration, opts)
        map("n", "grr", lsp.references, opts)
        map("n", "gri", lsp.implementation, opts)
        map("n", "grt", lsp.type_definition, opts)
        map("n", "grn", lsp.rename, opts)
        map("n", "gra", lsp.code_action, opts)
    end,
})

-- copy buffer path to clipboard
map("n", "yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end)
