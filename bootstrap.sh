#!/bin/bash
# bootstrap.sh - one-shot setup for a fresh Mac
#
# Usage on a brand-new machine:
#   1. Open Terminal
#   2. Install Xcode CLI tools: xcode-select --install   (wait for it to finish)
#   3. Run this script
#
# What it does:
#   - Installs Homebrew (if not present)
#   - Clones your dotfiles repo
#   - Runs brew bundle to install all apps/tools
#   - Symlinks dotfiles into place
#   - Sets up mise with default language versions

set -e

# ============================================================
# CONFIG — edit this once before pushing to GitHub
# ============================================================
DOTFILES_REPO="git@github.com:YOUR-USERNAME/dotfiles.git"   # ← change this
DOTFILES_DIR="$HOME/Developer/dotfiles"

# ============================================================
# Pretty output
# ============================================================
say() { echo ""; echo "▶ $1"; }
ok()  { echo "  ✓ $1"; }

# ============================================================
# 1. Xcode CLI tools check
# ============================================================
say "Checking Xcode Command Line Tools..."
if ! xcode-select -p >/dev/null 2>&1; then
  echo "  ✗ Xcode CLI tools missing. Run this first, wait for it to finish, then re-run:"
  echo "      xcode-select --install"
  exit 1
fi
ok "Xcode CLI tools installed"

# ============================================================
# 2. Homebrew
# ============================================================
say "Installing Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to current shell
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  ok "Homebrew installed"
else
  ok "Homebrew already installed"
fi

# ============================================================
# 3. Git (needed before clone) — usually comes with Xcode CLI
# ============================================================
if ! command -v git >/dev/null 2>&1; then
  say "Installing git..."
  brew install git
fi

# ============================================================
# 4. Clone dotfiles
# ============================================================
say "Cloning dotfiles..."
mkdir -p "$(dirname "$DOTFILES_DIR")"
if [ -d "$DOTFILES_DIR/.git" ]; then
  ok "Dotfiles repo already cloned at $DOTFILES_DIR"
else
  # Try SSH first, fall back to HTTPS if SSH key isn't set up yet
  if ! git clone "$DOTFILES_REPO" "$DOTFILES_DIR" 2>/dev/null; then
    HTTPS_REPO=$(echo "$DOTFILES_REPO" | sed 's|git@github.com:|https://github.com/|')
    echo "  SSH clone failed, falling back to HTTPS..."
    git clone "$HTTPS_REPO" "$DOTFILES_DIR"
  fi
  ok "Cloned to $DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# ============================================================
# 5. Install everything from Brewfile
# ============================================================
say "Running brew bundle (this takes a while — go grab coffee)..."
brew bundle --file=./Brewfile
ok "All brew packages installed"

# ============================================================
# 6. Symlink dotfiles
# ============================================================
say "Linking dotfiles..."
chmod +x ./install.sh
./install.sh

# ============================================================
# 7. mise — set up default language versions
# ============================================================
say "Setting up language versions with mise..."
eval "$(mise activate bash)"
mise use --global node@lts
mise use --global python@3.12
ok "Node LTS and Python 3.12 installed globally"

# ============================================================
# 8. Done!
# ============================================================
echo ""
echo "═══════════════════════════════════════════════════════"
echo "  ✓ Bootstrap complete"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Manual steps remaining:"
echo ""
echo "  1. Edit ~/.gitconfig — set your real name and email"
echo ""
echo "  2. Generate SSH key for GitHub:"
echo "       ssh-keygen -t ed25519 -C \"your-email@example.com\""
echo "       gh auth login   (easiest way to register the key)"
echo ""
echo "  3. In iTerm2 (or your terminal): set font to"
echo "       JetBrainsMono Nerd Font, size 14"
echo "     (otherwise prompt icons will look like boxes)"
echo ""
echo "  4. Restart your terminal (or run: source ~/.zshrc)"
echo ""
echo "  5. Launch nvim — plugins will auto-install on first run"
echo ""
