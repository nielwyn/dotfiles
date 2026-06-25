export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export ATAC_KEY_BINDINGS=~/.config/atac/vim_key_bindings.toml

if [[ $- == *i* ]]; then
  exec fish
fi
