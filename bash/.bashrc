export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export SUDO_EDITOR=/usr/bin/nvim

if [[ $- == *i* ]]; then
  exec fish
fi
