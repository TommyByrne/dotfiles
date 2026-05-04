# ~/.zshrc - clean, modern, no oh-my-zsh bloat

# ---- Homebrew (Apple Silicon path) ----
eval "$(/opt/homebrew/bin/brew shellenv)"

# ---- History ----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY            # share history across sessions
setopt HIST_IGNORE_ALL_DUPS     # no duplicates
setopt HIST_IGNORE_SPACE        # don't record commands starting with space
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY              # show !! before running
setopt INC_APPEND_HISTORY

# ---- Better completion ----
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case insensitive

# ---- Vim mode (since you use vim bindings) ----
bindkey -v
export KEYTIMEOUT=1
# ctrl-r for fzf history search even in vim mode
bindkey '^R' fzf-history-widget
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# ---- Plugins (installed via brew) ----
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Tools ----
eval "$(starship init zsh)"     # prompt
eval "$(zoxide init zsh)"       # smarter cd, use `z <partial>`
eval "$(mise activate zsh)"     # auto-activate node/python/ruby per project
source <(fzf --zsh)             # fzf keybindings (ctrl-r, ctrl-t, alt-c)

# ---- Aliases ----
# eza (ls replacement)
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first --git'
alias la='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --icons --level=2'

# bat (cat replacement)
alias cat='bat --paging=never'
alias less='bat'

# git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gco='git checkout'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# misc
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias vim='nvim'
alias vi='nvim'
alias reload='source ~/.zshrc'

# ---- Editor ----
export EDITOR='nvim'
export VISUAL='nvim'

# ---- Path additions ----
export PATH="$HOME/.local/bin:$PATH"

# ---- FZF defaults (use fd, look pretty) ----
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# ---- Local overrides (gitignored, machine-specific) ----
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
