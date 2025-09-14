return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    "fzf-tmux",
    defaults = {
      formatter = "path.filename_first",
    },
    fzf_opts = {
      ["--tmux"] = "center,100%,100%"
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
