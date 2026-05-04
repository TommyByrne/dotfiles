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
# ---- Quick shortcuts ----
alias c='clear'
alias cls='clear'
alias h='history'
alias q='exit'
alias x='exit'
alias path='echo $PATH | tr ":" "\n"'
alias reload='source ~/.zshrc'
alias zshrc='nvim ~/.zshrc'
alias dotfiles='cd ~/Developer/dotfiles'

# ---- Navigation ----
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias dev='cd ~/Developer'

# ---- eza (ls replacement) ----
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first --git'
alias la='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --icons --level=2'
alias ltt='eza --tree --icons --level=3'

# ---- bat (cat replacement) ----
alias cat='bat --paging=never'
alias less='bat'

# ---- git ----
alias g='git'
alias gs='git status'
alias gss='git status -s'                 # short status
alias gd='git diff'
alias gds='git diff --staged'             # staged changes
alias ga='git add'
alias gas='git add .'                     # add all
alias gco='git checkout'
alias gcb='git checkout -b'               # new branch
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit' # amend without editing message
alias gp='git push'
alias gpf='git push --force-with-lease'   # safer force push
alias gl='git pull'
alias gf='git fetch --all --prune'
alias gb='git branch'
alias gba='git branch -a'                 # all branches incl remote
alias gbd='git branch -d'                 # delete branch
alias glog='git log --oneline --graph --decorate'
alias gloga='git log --oneline --graph --decorate --all'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gr='git restore'
alias grs='git restore --staged'          # unstage
alias gclean='git clean -fd'
alias gwip='git add -A && git commit -m "WIP"'
alias gundo='git reset --soft HEAD~1'

# ---- editor ----
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias code.='code .'

# ---- mkdir + cd in one ----
mkcd() { mkdir -p "$1" && cd "$1"; }

# ---- find process by name ----
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# ---- network ----
alias myip='curl -s ifconfig.me && echo'
alias localip="ipconfig getifaddr en0"
alias ports='lsof -i -P -n | grep LISTEN'

# ---- macOS specific ----
alias finder='open .'                     # open current dir in Finder
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# ---- brew ----
alias bi='brew install'
alias bs='brew search'
alias bu='brew update && brew upgrade'
alias bc='brew cleanup'
alias bb='brew bundle --file=~/Developer/dotfiles/Brewfile'
alias bbcheck='brew bundle check --file=~/Developer/dotfiles/Brewfile'

# ---- mise ----
alias mu='mise use'
alias mug='mise use --global'
alias ml='mise ls'

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
