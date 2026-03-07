local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
}

vim.lsp.config("neocmake", {
  cmd = { "neocmakelsp", "stdio" },
  filetypes = { "cmake" },
  root_markers = { "CMakeLists.txt", ".git" },
  capabilities = capabilities,
})

vim.lsp.config["clangd"] = {
  cmd = {
    "clangd",
    "--background-index",
    "--completion-style=detailed",
    "--all-scopes-completion",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--fallback-style=chromium",
  },
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  single_file_support = true,
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}

vim.lsp.config["ts_ls"] = {
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
}

vim.lsp.config["sourcekit"] = {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}

vim.lsp.config['yamlls'] = {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = {
    'yaml',
    'yaml.docker-compose',
    'yaml.gitlab',
    'yaml.helm-values'
  },
}

vim.lsp.config['gopls'] = {
  cmd = { "gopls" },
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl" }
}

vim.lsp.enable({
  "lua_ls",
  "neocmake",
  "ts_ls",
  "sourcekit",
  "clangd",
  "pyright",
  "ast_grep",
  "bashls",
  "cssls",
  "gopls",
  "html",
  "jsonls",
  "omnisharp",
  "remark_ls",
  "vimls",
  "yamlls",
})

-- require("mason-lspconfig").setup {
--   ensure_installed = {
--     'ast_grep',
--     'bashls',
--     'clangd',
--     'cssls',
--     'gopls',
--     'html',
--     'jsonls',
--     'lua_ls',
--     'omnisharp',
--     'pyright',
--     'remark_ls',
--     'ts_ls',
--     'vimls',
--   },
-- }

local function lsp_on_attach(event)
  local opts = { buffer = event.buf }
  local lsp = vim.lsp.buf
  vim.keymap.set('n', 'K', lsp.hover, opts)
  vim.keymap.set('n', 'gd', lsp.definition, opts)
  vim.keymap.set('n', 'gD', lsp.declaration, opts)
  vim.keymap.set('n', 'gi', lsp.implementation, opts)
  vim.keymap.set('n', 'go', lsp.type_definition, opts)
  vim.keymap.set('n', 'gr', lsp.references, opts)
  vim.keymap.set('n', 'gs', lsp.signature_help, opts)
  vim.keymap.set('n', '<F2>', lsp.rename, opts)
  vim.keymap.set({ 'n', 'x' }, '<F3>', function() lsp.format { async = true } end, opts)
  vim.keymap.set('n', '<F4>', lsp.code_action, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = lsp_on_attach,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
