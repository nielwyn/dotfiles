return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      delay = 0,
    },
    indent = {
      enable = true,
      use_treesitter = false,
    },
  }
}
