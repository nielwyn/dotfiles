local map = vim.keymap.set

map({ "n", "v" }, "y", '"+y')
map({ "n", "v" }, "x", '"_x') -- Delete without yanking

map("n", "Y", '"+Y')

map("v", "<C-j>", ":m '>+1<CR>gv")
map("v", "<C-k>", ":m '<-2<CR>gv")

-- copy buffer path to clipboard
map("n", "yp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end)
