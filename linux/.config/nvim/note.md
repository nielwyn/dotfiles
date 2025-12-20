find . -name ".DS_Store" -print -delete
git clean
git restore

<!-- LazyGit Configuration -->
alias lg='LG_CONFIG_FILE="$HOME/Library/Application Support/lazygit/config.yml,$HOME/Library/Application Support/lazygit/tokyonight_moon.yml" lazygit'
