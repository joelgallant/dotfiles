#!/bin/env bash
set -euo pipefail

if ! which git > /dev/null; then
  sudo apt-get update && sudo apt-get install -y git
fi

if [ ! -e $HOME/dotfiles ]; then
  (cd $HOME && git clone https://github.com/joelgallant/dotfiles.git)
fi

cd $HOME/dotfiles

./setup-full.sh
