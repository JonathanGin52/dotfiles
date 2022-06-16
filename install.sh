#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

export TERM=xterm-256color

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
 zsh \
 tmux \
 jq \
 ripgrep \
 fzf

# Install latest neovim release
sudo apt-get install -y fuse
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv ./nvim.appimage /usr/local-bin/nvim

ln -s $(pwd)/home/.tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/home/.config/nvim $HOME/.config/nvim
ln -s $(pwd)/home/.config/bat $HOME/.config/bat

# ln -s $(pwd)/home/.zshrc $HOME/.zshrc

nvim +'PlugInstall --sync' +qa
sudo chsh -s "$(which zsh)" "$(whoami)"
