#!/bin/bash
set -e

# set cwd to folder containing script
cd "${0%/*}"

OLD_DOTFILES="$HOME/dotfiles_bk_$(date -u +"%Y-%m-%d_%H_%M_%S")"
mkdir "$OLD_DOTFILES"

function backup_if_exists() {
    FILE="$HOME/$1"
    if [ -f "$FILE" ];
    then
      mv "$FILE" "$OLD_DOTFILES"
    fi
    if [ -d "$FILE" ];
    then
      mv "$FILE" "$OLD_DOTFILES"
    fi
}

# backup conflicts
for f in $(ls -A dotfiles); do
  backup_if_exists "$f"
done

# create symlinks to dotfiles
stow dotfiles

# Install FZF (fuzzy finder on the terminal and used by a Vim plugin)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  || true
~/.fzf/install

echo DONE
