#!/bin/bash
# install.sh - symlink dotfiles into their proper locations
# Run this from inside your dotfiles repo: ./install.sh

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES"
echo ""

# Back up existing files that aren't already symlinks
backup() {
  if [ -e "$1" ] && [ ! -L "$1" ]; then
    echo "  Backing up existing $1 -> $1.backup"
    mv "$1" "$1.backup"
  fi
}

# Symlink helper
link() {
  local src="$1"
  local dst="$2"
  backup "$dst"
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "  Linked $(basename "$dst")"
}

echo "Linking home directory files..."
link "$DOTFILES/.zshrc"            "$HOME/.zshrc"
link "$DOTFILES/.gitconfig"        "$HOME/.gitconfig"
link "$DOTFILES/.gitignore_global" "$HOME/.gitignore_global"

echo ""
echo "Linking config directory files..."
link "$DOTFILES/starship.toml"     "$HOME/.config/starship.toml"
link "$DOTFILES/nvim/init.lua"     "$HOME/.config/nvim/init.lua"

echo ""
echo "✓ Dotfiles installed."
echo ""
echo "Next steps:"
echo "  1. Edit ~/.gitconfig with your name and email"
echo "  2. Run: source ~/.zshrc"
echo "  3. Open nvim — plugins will auto-install on first launch"
