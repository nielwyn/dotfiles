export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if [[ $- == *i* ]]; then
  exec fish
fi
