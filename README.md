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

For Linux:
```sh
stow -t ~ linux
```

For macOS:
```sh
stow -t ~ macos
```

### 3. Setup Swaybg (Wallpaper)

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
