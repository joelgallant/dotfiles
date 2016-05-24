export EDITOR=vim
export TERMINAL=terminator
export BROWSER=chromium
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoreboth:erasedups

alias caps2esc='setxkbmap -option caps:escape'
alias grep='grep --color=auto'
alias tmux='tmux -2'
alias mux='tmuxinator'

# 256 color mode
[[ $TMUX = "" ]] && export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=/home/joel/.oh-my-zsh
ZSH_THEME="sunaku"
CASE_SENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_TITLE="true"
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

setopt nosharehistory
