#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
 zsh \
 tmux \
 jq \
 ripgrep \
 fd-find \
 fzf

# Install latest neovim release
sudo apt-get install -y fuse
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x $(pwd)/nvim.appimage
sudo mv $(pwd)/nvim.appimage /usr/local/bin/nvim

ln -sf $(pwd)/home/.tmux.conf $HOME/.tmux.conf
ln -sf $(pwd)/home/.config/nvim $HOME/.config/nvim
ln -sf $(pwd)/home/.config/nvim $HOME/.config/nvim
ln -sf $(pwd)/home/.gitconfig $HOME/.gitconfig

# ln -s $(pwd)/home/.zshrc $HOME/.zshrc

echo "export TERM=xterm-256color" >> $HOME/.zshrc

nvim +'PlugInstall --sync' +qa
sudo chsh -s "$(which zsh)" "$(whoami)"
