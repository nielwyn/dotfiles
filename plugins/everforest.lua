return {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true
		vim.opt.background = "dark"
		vim.g.everforest_background = "medium"
		vim.g.everforest_better_performance = 1
		vim.g.everforest_transparent_background = 1
		vim.cmd.colorscheme("everforest")
	end,
}
