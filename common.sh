#!/bin/env bash
set -euo pipefail

DOTFILES_DIR=$(realpath $(dirname "$0"))

PACKAGES=()

function include_pkg() {
  PACKAGES+=( $@ )
}

function bold_msg() {
  echo -e "\e[1m$1\e[0m"
}

function install_msg() {
  bold_msg "--- Installing $1 ---"
}

function install_packages() {
  list=${PACKAGES[@]}
  num=${#PACKAGES[@]}
  if [[ -n "${list}" ]]; then
    install_msg "$num packages: $list"
    sudo apt-get install -y $list --no-install-recommends
    PACKAGES=()
  fi
}

function binary_or_override() {
  binary_name=$1
  override_var_name=${2:-INSTALL_${binary_name^^}}

  if ! which $binary_name > /dev/null || [[ "${!override_var_name:-}" == "1" ]]; then
    return 0
  else
    return 1
  fi
}

function final_steps() {
  install_packages # install any packages that were remaining
  sudo apt-get clean
  sudo apt-get -y autoremove
}

function setup_opt() {
  if [[ ! -e /opt/bin ]]; then
    sudo mkdir -p /opt/bin
  fi

  if [[ ! -w /opt ]]; then
    sudo chown -R $USER:$USER /opt
  fi
}


