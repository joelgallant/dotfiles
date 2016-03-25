export EDITOR=vim
export TERMINAL=terminator
export BROWSER=chromium
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoreboth:erasedups

if [ $(which thefuck) ]; then eval "$(thefuck --alias fuck)"; fi
alias caps2esc='setxkbmap -option caps:escape'
alias grep='grep --color=auto'
alias tmux='tmux -2'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# device specific
alias sync-blackberry='sudo rsync -rtzuv --no-p --no-o --delete /home/storage/music/ /run/media/joel/5502-3AFE/music'

# 256 color mode
[[ $TMUX = "" ]] && export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=/home/joel/.oh-my-zsh
ZSH_THEME="sunaku"
CASE_SENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh
