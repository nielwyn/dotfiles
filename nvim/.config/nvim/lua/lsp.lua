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

vim.lsp.config["rust-analyzer"] = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
}

vim.lsp.config["gopls"] = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
}

vim.lsp.config["neocmakelsp"] = {
    cmd = { "neocmakelsp", "stdio" },
    filetypes = { "cmake" },
    root_markers = { "CMakeLists.txt", ".git" },
}

vim.lsp.config["bash-language-server"] = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh" },
}

vim.lsp.config["fish-lsp"] = {
    cmd = { "fish-lsp", "start" },
    filetypes = { "fish" },
}

vim.lsp.config["pylsp"] = {
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
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

vim.lsp.config["svelteserver"] = {
    cmd = { "svelteserver", "--stdio" },
    filetypes = { "svelte" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}

vim.lsp.config["vscode-html-language-server"] = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
}

vim.lsp.config["vscode-css-language-server"] = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
}

vim.lsp.config["buf"] = {
    cmd = { "buf", "lsp", "serve" },
    filetypes = { "proto" },
    root_markers = { "buf.yaml", ".git" },
}

vim.lsp.config["postgres-language-server"] = {
    cmd = { "postgres-language-server", "lsp-proxy" },
    filetypes = { "sql" },
    root_markers = { "postgres-language-server.jsonc", ".git" },
}

vim.lsp.config["docker-language-server"] = {
    cmd = { "docker-language-server", "start", "--stdio" },
    filetypes = { "dockerfile" },
}

vim.lsp.config["vscode-json-language-server"] = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    settings = {
        json = {
            format = { enable = true },
        },
    },
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

vim.lsp.config["marksman"] = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
}

vim.lsp.enable({
    "clangd",
    "rust-analyzer",
    "gopls",
    "neocmakelsp",
    "bash-language-server",
    "fish-lsp",
    "pylsp",
    "lua-language-server",
    "vim-language-server",
    "typescript-language-server",
    "svelteserver",
    "vscode-html-language-server",
    "vscode-css-language-server",
    "buf",
    "postgres-language-server",
    "docker-language-server",
    "vscode-json-language-server",
    "yaml-language-server",
    "marksman",
})
