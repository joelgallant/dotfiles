export EDITOR=vim
export TERMINAL=terminator
export BROWSER=chromium
# Gtk themes 
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export PATH=$PATH:/home/joel/.gem/ruby/2.2.0/bin

alias ls='ls --color=auto'

alias syncbb='sudo rsync -rtzuv --no-p --no-o --delete /home/storage/music/ /run/media/joel/5502-3AFE/music'
alias mountwindows='sudo mount /dev/sdb2 /media/windows'
