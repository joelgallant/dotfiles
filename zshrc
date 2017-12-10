export EDITOR=nvim
export TERMINAL=terminator
export BROWSER=chromium
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoreboth:erasedups

alias caps2esc='setxkbmap -option caps:escape'
alias grep='grep --color=auto'
alias tmux='tmux -2'
alias t='tmux'
alias mux='tmuxinator'
alias vi='nvim .'

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.rvm/bin"
setopt nosharehistory
set -o vi
bindkey '\e.' insert-last-word

function title()
{
   echo -en "\e]2;$1\a"
}

function svndiff()
{
    svn diff $1 | colordiff | diff-so-fancy | less
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/joel/.sdkman"
[[ -s "/home/joel/.sdkman/bin/sdkman-init.sh" ]] && source "/home/joel/.sdkman/bin/sdkman-init.sh"
