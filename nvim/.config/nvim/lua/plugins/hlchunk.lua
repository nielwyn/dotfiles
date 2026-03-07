return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      delay = 100,
    },
    indent = {
      enable = true,
      use_treesitter = false,
    },
  }
}
