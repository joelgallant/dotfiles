#!/bin/env bash
set -euo pipefail
source ./common.sh

# Versions of stuff, if applicable
XBANISH_VERSION="v1.7"

if [[ "${DISABLE_SYSTEM_UPDATE:-}" != "1" ]]; then
  sudo apt-get update
fi

# Core Utilities For Install
include_pkg curl wget
include_pkg git
include_pkg stow
include_pkg gcc g++ make cmake pkg-config
include_pkg gnupg ca-certificates
include_pkg libssl-dev

install_packages

# User directories
if [ ! -e $HOME/.config/user-dirs.dir ]; then
  mkdir -p $HOME/documents $HOME/downloads $HOME/dev $HOME/libs $HOME/music $HOME/pictures $HOME/videos $HOME/.config
  ln -fsn $DOTFILES_DIR/user-dirs.dirs $HOME/.config/user-dirs.dirs
fi

# Configuration (files only), all using gnu stow
stow -t $HOME tmux
stow -t $HOME nvim
stow -t $HOME git
stow -t $HOME i3
stow -t $HOME starship

# NodeJS & Toolchain Install
if binary_or_override volta; then
  install_msg volta
  curl -fL https://get.volta.sh | bash

  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

if volta_component node; then
  install_msg node
  volta install node@lts
fi

if volta_component yarn; then
  install_msg yarn
  volta install yarn@1

  echo "prefix = $HOME/.npm-packages" >> $HOME/.npmrc
fi

# Rust & Toolchain Install
if binary_or_override rustc INSTALL_RUST; then
  install_msg rust

  curl -fL https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env

  rustup component add clippy
  rustup component add rustfmt
  rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy
fi

if binary_or_override cargo-deny; then
  install_msg cargo-deny
  cargo install cargo-deny
fi

if binary_or_override cargo-watch; then
  install_msg cargo-watch
  cargo install cargo-watch
fi

if binary_or_override cargo-outdated; then
  install_msg cargo-outdated
  cargo install cargo-outdated
fi

if binary_or_override cargo-release; then
  install_msg cargo-release
  cargo install cargo-release
fi

if binary_or_override cargo-deb; then
  install_msg cargo-deb
  cargo install cargo-deb
fi

# Toolchains and debuggers
include_pkg lldb gdb

# OpenJDK
if binary_or_override javac; then
  install_msg openjdk
  curl -fL https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public \
    | sudo apt-key add -
  echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main" \
    | sudo tee /etc/apt/sources.list.d/openjdk.list

  sudo apt-get update
  include_pkg adoptopenjdk-15-openj9
fi

# Kotlin
if binary_or_override kotlinc; then
  install_msg kotlin
  install_snap kotlin --classic
fi

# Swift
if binary_or_override swift; then
  install_msg swift
  setup_opt

  include_pkg libz3-4 libtinfo5 libncurses5 libpython2.7
  swift_version=swift-5.3-release/ubuntu1804/swift-5.3-RELEASE/swift-5.3-RELEASE-ubuntu18.04
  curl -fL --progress-bar https://swift.org/builds/$swift_version.tar.gz -o /tmp/swift.tar.gz

  mkdir -p /opt/swift && tar xf /tmp/swift.tar.gz  --strip 1 -C /opt/swift
  rm /tmp/swift.tar.gz

  sudo ln -s /opt/swift/usr/bin/swift /opt/bin/swift
fi

if binary_or_override go; then
  include_pkg golang
fi

if binary_or_override elm; then
  setup_opt
  elm_version=0.19.1
  curl -fL https://github.com/elm/compiler/releases/download/$elm_version/binary-for-linux-64-bit.gz | gunzip - > /opt/bin/elm
  chmod +x /opt/bin/elm
fi

# Docker
if binary_or_override docker; then
  install_msg docker
  curl -fL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list

  sudo apt-get update
  include_pkg docker-ce docker-ce-cli containerd.io && install_packages
  sudo usermod -aG docker $USER
fi

# tmux setup
include_pkg tmux

if [ ! -e $HOME/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

  install_packages # install tmux first
  tmux new -d # ensure tmux server is started
  tmux source $HOME/.tmux.conf
  $HOME/.tmux/plugins/tpm/bin/install_plugins all
fi

# CLI one-offs that I use often enough
include_pkg wget zip unzip tar jq
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

if binary_or_override starship; then
  install_msg starship
  cargo install starship
fi

# Fuzzy finder for terminal and vim
if [ ! -d $HOME/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --key-bindings --no-completion --no-update-rc
fi

# Text editors
include_pkg neovim

if binary_or_override code; then
  install_msg vscode
  curl -fL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list
  rm packages.microsoft.gpg
  sudo apt-get update
  include_pkg code
fi

# Plug for neovim plugins
if [ ! -e $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
  install_msg vim-plug
  install_packages # nvim
  curl -fL -o $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim -es -u $HOME/.config/nvim/init.vim  -i NONE -c "PlugInstall" -c "qa"
fi

# X Server & i3wm
if binary_or_override i3; then
  include_pkg i3 xorg
fi

# i3 status bar
if binary_or_override i3status-rs INSTALL_I3_STATUS; then
  include_pkg libdbus-1-dev libpulse0 && install_packages # links against libraries
  install_msg i3status-rs
  cargo install --git https://github.com/greshake/i3status-rust
fi

# xrandr and gui for monitor resolutions and layout
include_pkg x11-xserver-utils arandr

# dmenu to find and run programs
include_pkg dmenu

# st as a terminal
include_pkg stterm

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
include_pkg network-manager network-manager-gnome

# System sensors and power
include_pkg lm-sensors pm-utils

# Sound management
include_pkg pulseaudio pulseaudio-utils pavucontrol alsa-utils

# Virtual machines
include_pkg virt-manager

# GUI applications that I use often enough
include_pkg thunar evince transmission-gtk vlc smplayer gimp libreoffice-calc

# GVfs for thunar mounting
include_pkg gvfs gvfs-backends

# Fonts and other theming
include_pkg fonts-inconsolata fonts-font-awesome fonts-powerline libfreetype6-dev

# Web browsers
if binary_or_override firefox; then
  install_msg firefox
  setup_opt
  include_pkg libdbus-glib-1-2 # linked against, looks like it's loaded dynamically

  wget -O firefox.tar.gz "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"
  tar -xf firefox.tar.gz -C /opt
  rm firefox.tar.gz

  sudo ln -s /opt/firefox/firefox /opt/bin/firefox
fi

include_pkg chromium

if binary_or_override insomnia; then
  install_msg insomnia
  curl -fL https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
  echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee /etc/apt/sources.list.d/insomnia.list

  sudo apt-get update
  include_pkg insomnia
fi

if binary_or_override pgadmin4; then
  install_msg pgadmin
  curl -fL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" \
    | sudo tee /etc/apt/sources.list.d/postgres.list

  sudo apt-get update
  include_pkg pgadmin4
fi

if binary_or_override spotify; then
  install_msg spotify
  curl -fL https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
  curl -fL https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
  echo "deb http://repository.spotify.com stable non-free" \
    | sudo tee /etc/apt/sources.list.d/spotify.list

  sudo apt-get update
  include_pkg spotify-client
fi

# shell(s) - I use fish primarily but like having zsh available
if binary_or_override zsh; then
  install_msg zsh
  sudo apt-get install -y zsh
fi

if binary_or_override fish; then
  install_msg fish
  sudo apt-get install -y fish
  sudo usermod -s $(which fish) $USER
fi

stow -t $HOME fish

# Fisher package manager
if [ ! -e $HOME/.config/fish/functions/fisher.fish ]; then
  install_msg fisher plugin manager
  curl -fL https://git.io/fisher --create-dirs -o $HOME/.config/fish/functions/fisher.fish
fi

# plugin for shared ssh-agent across fish sessions
if [ ! -e ~/.config/fisher/github.com/danhper/fish-ssh-agent ]; then
  install_msg fish-ssh-agent
  fish --command="fisher add danhper/fish-ssh-agent"
fi

# SSH keys
if [ ! -e $HOME/.ssh/config ]; then
  mkdir -p $HOME/.ssh && touch $HOME/.ssh/config
fi

if [ ! -e $HOME/.ssh/github ]; then
  bold_msg "--- Creating github ssh key ---"
  ssh-keygen -t rsa -b 4096 -C "joel@joelgallant.me" -f $HOME/.ssh/github
  printf "\nHOST github.com\n  HostName github.com\n  IdentityFile $HOME/.ssh/github\n" >> $HOME/.ssh/config
  bold_msg "Remember to add ~/.ssh/github.pub key to the github GUI"
fi

final_steps # finish up any work that was queued up

echo -e "\e[1m--- We're done! ---\e[0m"
