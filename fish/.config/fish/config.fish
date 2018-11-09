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

# npm (node)
set -x NPM_PACKAGES $HOME/.npm-packages
set -x MANPATH $NPM_PACKAGES/share/man $MANPATH
set -x NODE_PATH $NPM_PACKAGES/lib/node_modules $NODE_PATH

# PATH modifications
set PATH $HOME/.cargo/bin $PATH
set PATH $NPM_PACKAGES/bin $PATH
set PATH /opt/bin $PATH

# for gpg
set -x GPG_TTY (tty)

# sudoedit
set -x EDITOR nvim

# respect gitignore
set -x FZF_DEFAULT_COMMAND 'fd --type f'

# Fish settings
set -g fish_key_bindings fish_vi_key_bindings

function fish_greeting
  printf (set_color brcyan)(date)(set_color white)' ('(set_color blue)(pwd)(set_color white)')\n'
end
