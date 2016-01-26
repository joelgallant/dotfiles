export EDITOR=vim
export TERMINAL=terminator
export BROWSER=chromium
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoreboth:erasedups
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

if [ $(which thefuck) ]; then eval "$(thefuck --alias fuck)"; fi
alias caps2esc='setxkbmap -option caps:escape'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tmux='tmux -2'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# device specific
alias syncBB='sudo rsync -rtzuv --no-p --no-o --delete /home/storage/music/ /run/media/joel/5502-3AFE/music'
alias tracerconsole='sudo minicom -l -D /dev/ttyUSB0'
alias tracertelnet='telnet 192.168.0.118'
alias disableexternalmonitor='xrandr --auto --output HDMI1 --left-of eDP1'

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}
