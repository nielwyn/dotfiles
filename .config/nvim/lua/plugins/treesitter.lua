return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup {
      -- ensure_installed = {
      --   "lua", "vim", "vimdoc", "query", "javascript", "typescript", "rust"
      -- },
      -- highlight = { enable = true },
    }
    require'nvim-treesitter'.install { 'rust', 'javascript', 'zig' }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '<filetype>' },
      callback = function() vim.treesitter.start() end,
    })
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
}
