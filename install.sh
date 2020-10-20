#!/bin/bash

set -e

cd "${0%/*}"

# Install apt packages from list
sudo apt-get update
sudo apt-get install -y $(cat apt-list)

# Install FZF (fuzzy finder on the terminal and used by a Vim plugin).
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Create symlinks to various dotfiles.
stow dotfiles
