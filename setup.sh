#!/bin/env bash
set -euo pipefail
source ./common.sh

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
binary_or_override cmake && include_pkg gcc g++ cmake

install_packages

# Versions of stuff, if applicable
XBANISH_VERSION="v1.7"

# NodeJS & Toolchain Install
if binary_or_override volta; then
  install_msg volta
  curl https://get.volta.sh | bash
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

# X Server & i3wm
if binary_or_override i3; then
  include_pkg i3 xorg
fi

# XBanish hides mouse automatically when typing
if binary_or_override xbanish; then
  include_pkg gcc libxext-dev libxt-dev libxfixes-dev libxi-dev
  install_packages
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
include_pkg thunar evince transmission-gtk vlc

# GVfs for thunar mounting
include_pkg gvfs gvfs-backends

# Fonts and other theming
include_pkg fonts-inconsolata fonts-font-awesome fonts-powerline libfreetype6-dev

final_steps # finish up any work that was queued up
