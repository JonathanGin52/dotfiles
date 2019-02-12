#!/bin/bash

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Use the latest version of Homebrew
brew update

# Upgrade any existing formulae
brew upgrade

# Install from Brewfile
brew bundle

# Remove outdated versions from the cellar
brew cleanup

