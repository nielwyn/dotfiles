alias lg=lazygit

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export BUN_INSTALL="$HOME/.bun" — from set -gx BUN_INSTALL $HOME/.bun
export PATH="$BUN_INSTALL/bin:$PATH" — from set -gx PATH $BUN_INSTALL/bin $PATH
