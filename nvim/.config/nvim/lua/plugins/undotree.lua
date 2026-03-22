return {
	"mbbill/undotree",
	keys = {
		{ "<Leader>u", "<cmd>UndotreeToggle<CR>" },
	},
	config = function()
		vim.g.undotree_WindowLayout = 2
	end,
}
