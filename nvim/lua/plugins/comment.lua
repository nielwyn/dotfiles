return {
  'numToStr/Comment.nvim',
  opts = {
    padding = true,
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      line = 'gc',
      block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
      above = 'gcO',
      below = 'gco',
      eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      basic = true,
      extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
  }
}
