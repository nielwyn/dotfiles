-- persistent undo
local undodir = vim.fn.expand("~/.undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p", "0o700")
end
vim.opt.undodir = undodir
vim.opt.undofile = true

local options = {
	number = false,
	relativenumber = true,
	signcolumn = "yes",
	colorcolumn = "80",
	statuscolumn = " %s%l%=%r",
	laststatus = 2,
	scrolloff = 10,
	sidescrolloff = 10,
	winborder = "single",
	hlsearch = false,
	breakindent = true,
	smartindent = true,
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	textwidth = 80,
	foldenable = false,
}

for name, value in pairs(options) do
	vim.opt[name] = value
end
