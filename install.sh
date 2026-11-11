#!/bin/bash
pkgs=(
  sof-firmware       # Intel DSP firmware; no audio device without it
  intel-media-driver # Intel VA-API driver; nothing else pulls it in
  iwd
  openssh
  reflector
  pipewire-pulse # sound server; pulls pipewire + wireplumber
  terminus-font  # TTY console font, set via FONT= in /etc/vconsole.conf
  niri
  xdg-desktop-portal-gnome # niri's portal impl; only one with ScreenCast
  swaybg
  brightnessctl
  wl-clipboard
  ttf-jetbrains-mono-nerd # terminal/editor font + nerd icons
  noto-fonts-cjk          # only source of CJK glyphs
  noto-fonts-emoji        # only source of color emoji
  alacritty
  tmux
  fish
  man-db
  man-pages
  unzip
  stow
  btop
  ripgrep
  fd  # fzf-lua files picker + fzf Ctrl-T/Alt-C
  fzf # shell Ctrl-R/Ctrl-T/Alt-C keys + nvim fzf-lua backend
  bat # fzf Ctrl-T preview; fzf-lua previews itself
  git
  docker
  go
  protobuf
  tree-sitter-cli # nvim-treesitter compiles its parsers with this
  neovim
  lazygit
  lazydocker
)

sudo pacman -S --needed "${pkgs[@]}"
# TODO: setup wireguard-tools (need Raspi)
