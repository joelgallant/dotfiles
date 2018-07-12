alias g="git"
alias y="yarn"
alias t="tmux"
alias vi="nvim"
alias vim="nvim"
alias ...="cd ../.."
alias ....="cd ../../.."

# npm (node)
set -x NPM_PACKAGES $HOME/.npm-packages
set -x MANPATH $NPM_PACKAGES/share/man $MANPATH
set -x NODE_PATH $NPM_PACKAGES/lib/node_modules $NODE_PATH

# golang
set -x GOROOT /opt/go
set -x GOPATH $HOME/go

# ruby
rvm default

# PATH modifications
set PATH $HOME/.cargo/bin $PATH
set PATH $NPM_PACKAGES/bin $PATH
set PATH $GOROOT/bin $GOPATH/bin $PATH

# xserver
set -x DISPLAY :0.0

# sudoedit
set -x EDITOR nvim

# Fish setttings
set -g fish_key_bindings fish_vi_key_bindings

function fish_greeting
  printf (set_color brcyan)(date)(set_color white)' ('(set_color blue)(pwd)(set_color white)')\n'
end
