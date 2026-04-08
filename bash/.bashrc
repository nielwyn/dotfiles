export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

if [[ $- == *i* ]]; then
  exec fish
fi
