# ------------
#
# ZSH Settings
#
# ------------

# Enable switching directories without using the cd command
setopt auto_cd

# Use vi mode
bindkey -v
export KEYTIMEOUT=1

# ------------
# Completion
#
# Commands that set the the style and options for zsh completion.
# Reference: https://thevaluable.dev/zsh-completion-guide-examples/
# ------------

# Initialize zsh completion
autoload -U compinit; compinit -u

# Set the styles for zsh completion including case insensitivity and grouping of options
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''

setopt ALWAYS_TO_END
setopt MENU_COMPLETE
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# ------------
# History
#
# Settings that remove any duplicates in history while searching.
# Reference: https://ianyepan.github.io/posts/moving-away-from-ohmyzsh
# ------------

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ------------
# Internal Utility Functions
#
# Functions for use in setting some variables and aliases.
# Reference: https://github.com/statico/dotfiles/blob/main/.zshrc
# ------------

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# Returns the version of a command if present, or n/a if unavailable.
_versionof() {
  if _has "$1"; then
    echo "$1 $($1 --version)"
  else
    echo "$1 n/a"
  fi
}

# ------------
#
# Environment Variables
#
# ------------

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# ------------
#
# Aliases
#
# ------------

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -1a --color=auto'
alias lah='ls -lah --color=auto'
alias dotconfig="cd ~/.dotfiles"
alias dotclean="rm ~/.Brewfile ~/.gitconfig ~/.gitignore_global ~/.vimrc ~/.zshrc && rm -rf ~/.config && rm -rf ~/.vim"
alias zshconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.vimrc"
alias vim="nvim"
alias h='cd ~'

# ------------
# Git
# ------------
alias g='git'
alias gcam='git commit -v -a -m '
alias glog='git log --oneline'
alias gs='git status -sb'
alias gp='git push -u origin HEAD'
alias gba="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# ------------
# Homebrew
# ------------
alias bbinstall='brew bundle --global'
alias bbdump='brew bundle dump --describe --force --global'
alias bblist='brew bundle list --global --all'
alias bform='brew ls --formulae'
alias bcask='brew ls --cask'
alias bupbrew='brew update'
alias bupform='brew upgrade --formulae'
alias bupcask='brew uprade --cask'

# -------------
# NVM
# -------------
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# -------------
# Fzf
# -------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/sbin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '

# -------------
# Zinit
#
# A Zsh plugin manager in active development
# Documentation: https://github.com/zdharma-continuum/zinit
# -------------
source /usr/local/opt/zinit/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light "zsh-users/zsh-autosuggestions"
zinit light "zsh-users/zsh-syntax-highlighting"

# -------------
# zsh-autosuggestions
#
# Fish-like fast/unobtrusive autosuggestions for zsh.
# It suggests commands as you type based on history and completions.
# Documentation: https://github.com/zsh-users/zsh-autosuggestions/#key-bindings
# -------------

bindkey '^l' autosuggest-accept
bindkey '^k' autosuggest-execute
bindkey '^h' autosuggest-clear

# -------------
# RVM
#
# Make sure this is the last PATH variable change.
# -------------
export PATH="$PATH:$HOME/.rvm/bin"

# -------------
# Starship Prompt
#
# The minimal, blazing-fast, and infinitely customizable prompt for any shell!
# Documentation: https://starship.rs/config/
# -------------
eval "$(starship init zsh)"

# -------------
# Coreutils 
# -------------
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
