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
        map("n", "grr", "<cmd>Trouble lsp_references toggle<cr>", opts)
        map("n", "gri", lsp.implementation, opts)
        map("n", "grt", lsp.type_definition, opts)
        map("n", "grn", lsp.rename, opts)
        map("n", "gra", lsp.code_action, opts)
    end,
})

-- Copy buffer path to clipboard
map("n", "yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end)

local function tmux_navigate(direction)
    local win = vim.api.nvim_get_current_win()
    vim.cmd('wincmd ' .. direction)

    -- If the window ID didn't change, this is a Neovim edge, move tmux instead.
    if win == vim.api.nvim_get_current_win() then
        local tmux_directions = { h = 'L', j = 'D', k = 'U', l = 'R' }
        vim.fn.system('tmux select-pane -' .. tmux_directions[direction])
    end
end

map('n', '<C-h>', function() tmux_navigate('h') end)
map('n', '<C-j>', function() tmux_navigate('j') end)
map('n', '<C-k>', function() tmux_navigate('k') end)
map('n', '<C-l>', function() tmux_navigate('l') end)

map("n", "<M-Left>", "<cmd>vertical resize -5<cr>")
map("n", "<M-Right>", "<cmd>vertical resize +5<cr>")
map("n", "<M-Up>", "<cmd>resize +5<cr>")
map("n", "<M-Down>", "<cmd>resize -5<cr>")
