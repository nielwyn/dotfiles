local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config["luals"] = {
  capabilities = capabilities,
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
}

vim.lsp.config["clangd"] = {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { 'compile_commands.json', '.git' },
  init_options = {
    fallbackFlags = { "--std=c++20" }
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

vim.lsp.enable({
  "luals",
  "ts_ls",
  "sourcekit",
  "clangd",
  "pyright",
  -- "typescript-language-server",
  "ast_grep",
  "bash-language-server",
  "beautysh",
  "css-lsp",
  "gopls",
  "html-lsp",
  "json-lsp",
  -- "lua-language-server",
  "omnisharp",
  "remark-language-server",
  "vim-language-server",
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
