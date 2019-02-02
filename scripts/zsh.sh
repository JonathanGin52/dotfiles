#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `zsh.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install zsh syntax highlighting
git -C ~/.oh-my-zsh/custom/plugins clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# Install zsh autosuggestions
git -C ~/.oh-my-zsh/custom/plugins clone https://github.com/zsh-users/zsh-autosuggestions

# Install powerlevel9k theme
git -C ~/.oh-my-zsh/custom/themes clone https://github.com/bhilburn/powerlevel9k.git

# Install fonts
cp "Source Code Pro for Powerline.otf" ~/Library/Fonts

# Copy iterm2 settings
cp com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

# Change default shell to zsh
zsh_path=$(which zsh)
grep -Fxq "$zsh_path" /etc/shells || sudo bash -c "echo $zsh_path >> /etc/shells"
chsh -s "$zsh_path" $USER

