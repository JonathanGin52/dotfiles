#!/bin/bash

# Install zsh
brew info zsh | grep --quiet 'Not installed' && brew install zsh

# Install alacritty
brew cask info alacritty | grep --quiet 'Not installed' && brew cask install alacritty

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install zsh syntax highlighting
git -C ~/.oh-my-zsh/custom/plugins clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# Install zsh autosuggestions
git -C ~/.oh-my-zsh/custom/plugins clone https://github.com/zsh-users/zsh-autosuggestions

# Install pure prompt
npm install --global pure-prompt

# Add italics support in terminal and tmux
tic -x shell/xterm-256color-italic.terminfo
tic -x shell/tmux-256color-italic.terminfo

# Symlink alacritty config
mkdir -p ~/.config/alacritty
ln -sf shell/alacritty.yml ~/.config/alacritty/alacritty.yml

# Install fzf command tools
/usr/local/opt/fzf/install

# Change default shell to zsh
zsh_path=$(which zsh)
grep -Fxq "$zsh_path" /etc/shells || sudo bash -c "echo $zsh_path >> /etc/shells"
chsh -s "$zsh_path" $USER
