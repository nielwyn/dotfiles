return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<Leader>fr", "<cmd>FzfLua live_grep resume=true<CR>" },
		{ "<Leader>fc", "<cmd>FzfLua lgrep_curbuf<CR>" },
		{ "<Leader>fb", "<cmd>FzfLua buffers<CR>" },
		{ "<Leader>fa", "<cmd>FzfLua live_grep<CR>" },
		{ "<Leader>fw", "<cmd>FzfLua grep_cword<CR>" },
		{ "<Leader>ff", "<cmd>FzfLua files<CR>" },
		{ "<Leader>fh", "<cmd>FzfLua helptags<CR>" },
		{ "<Leader>fo", "<cmd>FzfLua oldfiles<CR>" },
		{ "<Leader>fs", "<cmd>FzfLua git_status<CR>" },
		{ "<Leader>o", "<cmd>FzfLua lsp_document_symbols<CR>" },
	},
	opts = {
		"fzf-tmux",
		defaults = {
			formatter = "path.filename_first",
		},
		fzf_opts = {
			["--tmux"] = "center,100%,100%",
			["--sort"] = true,
		},
		winopts = {
			height = 1,
			width = 1,
			preview = {
				layout = "vertical",
			},
		},
		previewers = {
			bat = {
				args = "--color=always --style=numbers,changes,header --theme=TwoDark",
			},
		},
	},
}
