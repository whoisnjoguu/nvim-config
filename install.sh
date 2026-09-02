#!/bin/sh
# Installs the nvim-config Neovim configuration (macOS + Linux).
# Usage: curl -fsSL https://raw.githubusercontent.com/whoisnjoguu/nvim-config/master/install.sh | sh
set -eu

REPO_URL="https://github.com/whoisnjoguu/nvim-config"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

say() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33mwarn:\033[0m %s\n' "$1"; }
die() { printf '\033[1;31merror:\033[0m %s\n' "$1" >&2; exit 1; }

have() { command -v "$1" >/dev/null 2>&1; }

have git || die "git is required"
have nvim || die "neovim is required (https://neovim.io)"
nvim --headless "+lua if vim.fn.has('nvim-0.11') == 0 then os.exit(1) end" +q >/dev/null 2>&1 \
  || die "neovim 0.11+ is required (found $(nvim --version | head -1))"

# Install a package using whatever package manager is available.
# Args: brew_pkg apt_pkg dnf_pkg pacman_pkg zypper_pkg
install_pkg() {
  brew_pkg="$1"; apt_pkg="$2"; dnf_pkg="$3"; pacman_pkg="$4"; zypper_pkg="$5"
  if have brew; then
    brew install "$brew_pkg"
  elif have apt-get; then
    sudo apt-get update -qq && sudo apt-get install -y "$apt_pkg"
  elif have dnf; then
    sudo dnf install -y "$dnf_pkg"
  elif have pacman; then
    sudo pacman -S --noconfirm "$pacman_pkg"
  elif have zypper; then
    sudo zypper install -y "$zypper_pkg"
  else
    return 1
  fi
}

# Search/build tooling used by telescope and nvim-treesitter.
ensure_tool() {
  tool="$1"; shift
  have "$tool" && return 0
  say "Installing $tool"
  install_pkg "$@" || warn "could not auto-install $tool; install it manually"
}

if have brew || have apt-get || have dnf || have pacman || have zypper; then
  #          cmd          brew            apt             dnf             pacman          zypper
  ensure_tool rg          ripgrep         ripgrep         ripgrep         ripgrep         ripgrep
  ensure_tool fd          fd              fd-find         fd-find         fd              fd
  ensure_tool tree-sitter tree-sitter-cli tree-sitter-cli tree-sitter-cli tree-sitter-cli tree-sitter
  ensure_tool cc          gcc             build-essential gcc             gcc             gcc
  ensure_tool make        make            build-essential make            make            make
else
  for tool in rg fd tree-sitter cc make; do
    have "$tool" || warn "$tool not found and no known package manager; install it for full functionality"
  done
fi

# Debian/Ubuntu ship fd-find as the `fdfind` binary; telescope expects `fd`.
if ! have fd && have fdfind; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  warn "linked fdfind -> ~/.local/bin/fd (ensure ~/.local/bin is on your PATH)"
fi

# Existing install: update in place. Anything else: back it up.
if [ -e "$DEST" ] || [ -L "$DEST" ]; then
  if git -C "$DEST" remote get-url origin 2>/dev/null | grep -q "nvim-config"; then
    say "Existing install detected, pulling latest"
    git -C "$DEST" pull --ff-only
  else
    backup="$DEST.bak.$(date +%Y%m%d%H%M%S)"
    say "Backing up existing config to $backup"
    mv "$DEST" "$backup"
  fi
fi

if [ ! -e "$DEST" ]; then
  say "Cloning $REPO_URL"
  git clone --depth 1 "$REPO_URL" "$DEST"
fi

say "Bootstrapping plugins (headless, may take a minute)"
nvim --headless "+Lazy! sync" +qa || warn "plugin sync had errors; open nvim and run :Lazy sync"

say "Done. Launch nvim — Mason will finish installing LSP servers on first start."
say "Tip: use a Nerd Font (https://www.nerdfonts.com) in your terminal for icons."
