# Dotfiles

My macOS dev machine setup. Modern, minimal, fresh-start friendly.

## 🚀 Setup on a new machine

Three commands. That's it.

```bash
# 1. Install Xcode CLI tools (wait for the popup to finish)
xcode-select --install

# 2. Run the bootstrap (it does everything else)
curl -fsSL https://raw.githubusercontent.com/YOUR-USERNAME/dotfiles/main/bootstrap.sh | bash
```

The bootstrap script will:
- Install Homebrew
- Clone this repo to `~/Developer/dotfiles`
- Install all apps and CLI tools from the Brewfile
- Symlink all dotfiles into place
- Set up mise with Node LTS + Python 3.12

After it finishes:
1. Edit `~/.gitconfig` with your name/email
2. Set up SSH key for GitHub (`ssh-keygen -t ed25519` then `gh auth login`)
3. Set terminal font to **JetBrainsMono Nerd Font**
4. Open nvim — plugins auto-install

---

## 📂 What's in here

| File | Goes to | Purpose |
|------|---------|---------|
| `Brewfile` | n/a | All apps + CLI tools |
| `bootstrap.sh` | n/a | One-shot fresh-machine setup |
| `install.sh` | n/a | Symlinks dotfiles (called by bootstrap) |
| `.zshrc` | `~/.zshrc` | Shell config |
| `.gitconfig` | `~/.gitconfig` | Git defaults + aliases |
| `.gitignore_global` | `~/.gitignore_global` | Global gitignore |
| `starship.toml` | `~/.config/starship.toml` | Prompt |
| `nvim/init.lua` | `~/.config/nvim/init.lua` | Neovim config |

---

## 🔧 Day-to-day

**Tweaking a config:** Just edit the file in this repo (the symlinked versions in your home directory point back here). Then commit + push.

```bash
cd ~/Developer/dotfiles
git add .
git commit -m "what you changed"
git push
```

**Syncing to another machine:**
```bash
cd ~/Developer/dotfiles
git pull
source ~/.zshrc
```

**Machine-specific stuff** (work env vars, secrets, paths):
Drop them in `~/.zshrc.local` — it's gitignored and auto-sourced by `.zshrc`.

---

## ⌨️ Cheatsheet

### Zsh aliases
- `ll` / `la` / `lt` — pretty listings (eza)
- `g`, `gs`, `gd`, `gco`, `gcm`, `gp`, `gl`, `glog` — git shortcuts
- `z <partial>` — jump to any directory you've been in
- `vim` / `vi` — opens nvim

### FZF keybinds
- `ctrl-r` — fuzzy history search
- `ctrl-t` — fuzzy file picker
- `alt-c` — fuzzy cd

### Neovim (leader = space)
- `<space>e` — toggle file tree
- `<space>ff` — find files
- `<space>fg` — grep across project
- `<space>fb` — switch buffers
- `<space>fr` — recent files
- `gd` — go to definition · `K` — hover docs
- `<space>ca` — code action · `<space>rn` — rename
- `gcc` — toggle line comment
- `<space>w` / `<space>q` — save / quit

### Mise
- `mise use node@lts` — set node version for current dir (creates `.mise.toml`)
- `mise use --global python@3.12` — global default
- `mise ls` — see installed versions
