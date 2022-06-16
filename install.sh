#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

sudo apt-get install -y neovim fzf ripgrep tmux

ln -s $(pwd)/home/.tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/home/.config/nvim $HOME/.config/nvim
ln -s $(pwd)/home/.config/bat $HOME/.config/bat

# ln -s $(pwd)/home/.zshrc $HOME/.zshrc

nvim +'PlugInstall --sync' +qa
sudo chsh -s "$(which zsh)" "$(whoami)"
