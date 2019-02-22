#!/bin/bash

# Use the latest version of Homebrew
brew update

# Upgrade any existing formulae
brew upgrade

# Install from Brewfile
brew bundle

# Remove outdated versions from the cellar
brew cleanup

