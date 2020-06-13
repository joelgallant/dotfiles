#!/bin/env bash
set -euo pipefail

if ! which git > /dev/null; then
  sudo apt-get update && sudo apt-get install -y git
fi

if [ ! -e $HOME/dotfiles ]; then
  (cd $HOME && git clone https://github.com/joelgallant/dotfiles.git --branch main)
else
  (cd $HOME/dotfiles && git pull)
fi

if [ ! -e $HOME/dotfiles/setup-full.sh ]; then
  echo "setup-full.sh not in dotfiles, you're probably in an old setup"
  exit 1
fi

(cd $HOME/dotfiles && ./setup-full.sh)
