set -g fish_key_bindings fish_vi_key_bindings

set PATH $HOME/.cargo/bin $PATH

alias g="git"
alias t="tmux"

function fish_greeting
  printf (set_color brcyan)(date)(set_color white)' ('(set_color blue)(pwd)(set_color white)')\n'
end
