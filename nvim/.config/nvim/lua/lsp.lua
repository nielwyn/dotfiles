vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config["clangd"] = {
	cmd = { "clangd", "--background-index", "--completion-style=detailed" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		"compile_commands.json",
		"compile_flags.txt",
		".clangd",
		".git",
	},
}

vim.lsp.config["neocmakelsp"] = {
	cmd = { "neocmakelsp", "stdio" },
	filetypes = { "cmake" },
	root_markers = { "CMakeLists.txt", ".git" },
}

vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work", ".git" },
}

vim.lsp.config["bash-language-server"] = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh" },
	root_markers = { ".git" },
}

vim.lsp.config["fish-lsp"] = {
	cmd = { "fish-lsp", "start" },
	filetypes = { "fish" },
}

vim.lsp.config["lua-language-server"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
}

vim.lsp.config["vim-language-server"] = {
	cmd = { "vim-language-server", "--stdio" },
	filetypes = { "vim" },
}

vim.lsp.config["python-lsp-server"] = {
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
}

vim.lsp.config["typescript-language-server"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}

vim.lsp.config["css-lsp"] = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
}

vim.lsp.config["json-lsp"] = {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
}

vim.lsp.config["yaml-language-server"] = {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = {
		"yaml",
		"yaml.docker-compose",
		"yaml.gitlab",
		"yaml.helm-values",
	},
}

vim.lsp.enable({
	"clangd",
	"neocmakelsp",
	"gopls",
	"bash-language-server",
	"fish-lsp",
	"lua-language-server",
	"vim-language-server",
	"python-lsp-server",
	"typescript-language-server",
	"css-lsp",
	"json-lsp",
	"yaml-language-server",
})
