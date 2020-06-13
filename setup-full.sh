#!/bin/env bash
set -euo pipefail
source ./common.sh

# Versions of stuff, if applicable
XBANISH_VERSION="v1.7"

if [[ "${DISABLE_SYSTEM_UPDATE:-}" != "1" ]]; then
  sudo apt-get update
fi

if binary_or_override zsh; then
  install_msg zsh
  sudo apt-get install -y zsh
  sudo usermod -s $(which zsh) $USER
fi

# Core Utilities For Install
binary_or_override curl && include_pkg curl
binary_or_override wget && include_pkg wget
binary_or_override git && include_pkg git
binary_or_override stow && include_pkg stow
binary_or_override cmake && include_pkg gcc g++ make cmake
binary_or_override gpg && include_pkg gnupg

install_packages

# User directories
if [ ! -e $HOME/.config/user-dirs.dir ]; then
  mkdir -p $HOME/documents $HOME/downloads $HOME/dev $HOME/libs $HOME/music $HOME/pictures $HOME/videos $HOME/.config
  ln -fsn $DOTFILES_DIR/user-dirs.dirs $HOME/.config/user-dirs.dirs
fi

# NodeJS & Toolchain Install
if binary_or_override volta; then
  install_msg volta
  curl https://get.volta.sh | bash
  source ~/.bashrc
fi

if binary_or_override node; then
  install_msg node
  volta install node@lts
fi

if binary_or_override yarn; then
  install_msg yarn
  volta install yarn

  echo "prefix = $HOME/.npm-packages" >> $HOME/.npmrc
fi

# Rust & Toolchain Install
if binary_or_override rustc INSTALL_RUST; then
  install_msg rust

  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source $HOME/.cargo/env
fi

# tmux setup
include_pkg tmux

if [ ! -e $HOME/.tmux.conf ]; then
  install_msg "tmux configuration"
  stow tmux
fi

if [ ! -e $HOME/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

  install_packages # install tmux first
  tmux new -d # ensure tmux server is started
  tmux source $HOME/.tmux.conf
  $HOME/.tmux/plugins/tpm/bin/install_plugins all
fi

# CLI one-offs that I use often enough
include_pkg zip unzip tar jq
include_pkg htop glances
include_pkg tree ncdu
include_pkg neofetch inxi

if binary_or_override rg INSTALL_RIPGREP; then
  install_msg ripgrep
  cargo install ripgrep
fi

if binary_or_override fd; then
  install_msg fd
  cargo install fd-find
fi

if binary_or_override sd; then
  install_msg sd
  cargo install sd
fi
if binary_or_override exa; then
  install_msg exa
  cargo install exa
fi

if binary_or_override bat; then
  install_msg bat
  cargo install bat
fi

if binary_or_override dust; then
  install_msg dust
  cargo install du-dust
fi

if binary_or_override delta; then
  install_msg delta
  cargo install --git https://github.com/dandavison/delta
fi

if binary_or_override tokei; then
  install_msg tokei
  cargo install tokei
fi

if binary_or_override bandwhich; then
  install_msg bandwhich
  cargo install bandwhich
fi

# Fuzzy finder for terminal and vim
if [ ! -d $HOME/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --key-bindings --no-completion --no-update-rc
fi

# Text editors
include_pkg neovim

# TODO: plug and friends

# X Server & i3wm
if binary_or_override i3; then
  include_pkg i3 xorg
fi

# i3 status bar
if binary_or_override i3status-rs INSTALL_I3_STATUS; then
  include_pkg libdbus-1-dev && install_packages # links against dbus library
  cargo install --git https://github.com/greshake/i3status-rust
fi

# dmenu to find and run programs
include_pkg dmenu

# XBanish hides mouse automatically when typing
if binary_or_override xbanish; then
  include_pkg gcc libxext-dev libxt-dev libxfixes-dev libxi-dev && install_packages
  setup_opt

  install_msg xbanish

  # would only be relevant for INSTALL_XBANISH override
  [ -d /opt/xbanish ] && rm -rf /opt/xbanish

  git clone -q --branch $XBANISH_VERSION https://github.com/jcs/xbanish.git /opt/xbanish 2> /dev/null
  (cd /opt/xbanish && sudo make install)
fi

# X Server utilities
include_pkg scrot feh xclip xbacklight

# Keyboard utilities to help with rebinding and setting numlock
include_pkg x11-xkb-utils numlockx

# Network management
include_pkg network-manager

# System sensors and power
include_pkg lm-sensors pm-utils

# Sound management
include_pkg pulseaudio pulseaudio-utils pavucontrol

# GUI applications that I use often enough
include_pkg thunar evince transmission-gtk vlc smplayer

# GVfs for thunar mounting
include_pkg gvfs gvfs-backends

# Fonts and other theming
include_pkg fonts-inconsolata fonts-font-awesome fonts-powerline libfreetype6-dev

# Insomnia GUI for hitting APIs
if binary_or_override insomnia; then
  echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
  wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -

  sudo apt-get update
  include_pkg insomnia
fi

final_steps # finish up any work that was queued up

