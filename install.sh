#!/bin/bash

cd "${0%/*}"

# Install apt packages from list
sudo apt-get update
sudo apt-get install -y $(cat apt-list)

# Install FZF (fuzzy finder on the terminal and used by a Vim plugin).
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Create symlinks to various dotfiles. If you didn't clone it to ~/dotfiles
# then adjust the symlink source (left side) to where you cloned it.
#
# NOTE: The last one is WSL 1 / 2 specific. No need to do this on native Linux.
# ln -s ~/dotfiles/.aliases ~/.aliases \
# && ln -s ~/dotfiles/.bashrc ~/.bashrc \
# && ln -s ~/dotfiles/.gemrc ~/.gemrc \
# && ln -s ~/dotfiles/.gitconfig ~/.gitconfig \
# && ln -s ~/dotfiles/.profile ~/.profile \
# && ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf \
# && ln -s ~/dotfiles/.vimrc ~/.vimrc \
# && sudo ln -s ~/dotfiles/etc/wsl.conf /etc/wsl.conf

# Create your own personal ~/.gitconfig.user file. After copying the file,
# you should edit it to have your name and email address so git can use it.
# cp ~/dotfiles/.gitconfig.user ~/.gitconfig.user
