local lspconfig = require('lspconfig')
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('lua_ls', { capabilities = capabilities })

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  init_options = { hostInfo = 'neovim' },
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
})


lspconfig.sourcekit.setup {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}

require("mason-lspconfig").setup {
  ensure_installed = {
    'ast_grep',
    'bashls',
    'clangd',
    'cssls',
    'gopls',
    'html',
    'jsonls',
    'lua_ls',
    'omnisharp',
    'pyright',
    'remark_ls',
    'ts_ls',
    'vimls',
  },
}

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
