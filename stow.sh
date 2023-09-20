# create symlinks to dotfiles
stow --verbose=2 --dotfiles dotfiles
ln -s dotfiles/config/kitty.conf ~/.config/kitty/kitty.conf
