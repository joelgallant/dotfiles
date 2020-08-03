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

alias k=kubectl
alias kctx=kubectx
alias kns=kubens

# npm (node)
set -x NPM_PACKAGES $HOME/.npm-packages
set -x NODE_PATH $NPM_PACKAGES/lib/node_modules $NODE_PATH

# python global installs
set -x PYTHONPATH '/usr/local/python' $PYTHONPATH

# android dev setup
set -x ANDROID_HOME /opt/android-sdk

# PATH modifications
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH $NPM_PACKAGES/bin
set -x PATH $PATH /snap/bin
set -x PATH $PATH /opt/bin
set -x PATH $PATH $HOME/.pulumi/bin
set -x PATH $PATH /opt/anaconda3/bin

# look in local for installed shared libs
set -x LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/local/lib

# for gpg
set -x GPG_TTY (tty)

# sudoedit
set -x EDITOR nvim

# respect gitignore, include dotfiles
set -x FZF_DEFAULT_COMMAND 'fd -t f -H -E .git'

# volta
set -gx VOLTA_HOME "$HOME/.volta"
test -s "$VOLTA_HOME/load.fish"; and source "$VOLTA_HOME/load.fish"
string match -r ".volta" "$PATH" > /dev/null; or set -gx PATH "$VOLTA_HOME/bin" $PATH

# Fish settings
set -g fish_key_bindings fish_vi_key_bindings

function fish_greeting; end
function fish_right_prompt; end

if which starship > /dev/null
  starship init fish | source
end
