return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    { "fzf-native", "border-fused" },
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
      }
    },
    previewers = {
      bat = {
        args = "--style=numbers,changes --color=always --theme=TwoDark",
      }
    }
  }
}
