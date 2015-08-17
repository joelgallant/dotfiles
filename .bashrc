export EDITOR=vim
export TERMINAL=terminator
export BROWSER=chromium
# Gtk themes 
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export PATH=$PATH:/home/joel/.gem/ruby/2.2.0/bin

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

set -o vi
eval "$(thefuck --alias fuck)"
alias ls='ls --color=auto'
alias syncbb='sudo rsync -rtzuv --no-p --no-o --delete /home/storage/music/ /run/media/joel/5502-3AFE/music'
alias mountwindows='sudo mount /dev/sdb2 /media/windows'
alias tracerconsole='sudo minicom -l'
alias tracertelnet='telnet 10.0.0.3'

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
