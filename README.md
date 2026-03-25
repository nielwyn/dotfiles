# My Dotfiles

## Requirements
- **GNU Stow**

## Installation

### 1. Setup Copilot (Optional)
Authenticate Copilot in Neovim by running:
```vim
:Copilot setup
```

### 2. Symlink Dotfiles Using Stow

Run from the `dotfiles` directory. Stow each package you want:

```sh
stow -t ~ alacritty bash fish gitconfig lazygit nvim tmux
```

Linux-only packages (Wayland/systemd):
```sh
stow -t ~ niri systemd
```

Or stow everything at once on Linux:
```sh
stow -t ~ alacritty bash fish gitconfig lazygit niri nvim systemd tmux
```

### 3. Setup Swaybg (Wallpaper) **[Linux Only]**

> The following setup is for Linux systems running Sway or other Wayland compositors.

Enable `swaybg.service` to start with compositor (e.g., niri) using:
```sh
systemctl --user add-wants niri.service swaybg.service
```

After editing `swaybg.service`, reload systemd to apply changes:
```sh
systemctl --user daemon-reload
```

**Tip:**  
Always run `systemctl --user daemon-reload` after modifying `~/.config/systemd/user/swaybg.service` so changes take effect.

---
