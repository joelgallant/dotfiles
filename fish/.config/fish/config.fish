alias ll="exa -la"
alias la="exa -a"
alias g="git"
alias y="yarn"
alias t="tmux"
alias m="make"
alias vi="nvim"
alias vim="nvim"
alias ...="cd ../.."
alias ....="cd ../../.."

alias gpull="git pull"
alias gpush="git push"
alias gup="git up"

# always ssh in xterm-256color
alias ssh='TERM=xterm-256color /usr/bin/ssh'

alias k=kubectl
alias kctx=kubectx
alias kns=kubens

# npm (node)
set -x NPM_PACKAGES $HOME/.npm-packages
set -x NODE_PATH $NPM_PACKAGES/lib/node_modules $NODE_PATH

# python global installs
set -x PYTHONPATH '/usr/local/python' $PYTHONPATH

set -x GOROOT /opt/go
set -x GOPATH $HOME/go

# android dev setup
set -x ANDROID_HOME /opt/android-sdk

# volta
set -gx VOLTA_HOME "$HOME/.volta"

# PATH modifications
set -xp PATH $ANDROID_HOME/platform-tools
set -xa PATH $GOPATH/bin
set -xa PATH $HOME/.cargo/bin
set -xa PATH $VOLTA_HOME/bin
set -xa PATH $NPM_PACKAGES/bin
set -xa PATH /opt/anaconda3/bin
set -xa PATH $HOME/.pulumi/bin
set -xa PATH /snap/bin
set -xp PATH /opt/bin
set -x PATH (printf '%s\n' $PATH | awk '!visited[$0]++' )

# look in local for installed shared libs
set -x LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/local/lib

# for gpg
set -x GPG_TTY (tty)

# sudoedit
set -x EDITOR nvim

# respect gitignore, include dotfiles
set -x FZF_DEFAULT_COMMAND 'fd -t f -H -E .git'

# Fish settings
set -g fish_key_bindings fish_vi_key_bindings

# digital ocean completions
if which doctl > /dev/null
  source (doctl completion fish | psub)
end

function fish_greeting; end
function fish_right_prompt; end

if which starship > /dev/null
  starship init fish | source
end
