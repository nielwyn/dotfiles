# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Lazygit config path
LG_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/lazygit"
alias lg="LG_CONFIG_FILE=\"$LG_CONFIG_DIR/config.yml\" lazygit"
