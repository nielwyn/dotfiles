return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    { "fzf-tmux" },
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
        args = "--color=always --style=numbers,changes,header --theme=TwoDark",
      }
    }
  }
}
