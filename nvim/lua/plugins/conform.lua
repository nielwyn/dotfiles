return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      python = { "isort", "black", stop_after_first = true },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = false,
    formatters = {
      shfmt = {
        append_args = { "-i", "2" },
      },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
