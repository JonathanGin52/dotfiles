#!/bin/bash

# Install xcode cli tools
xcode-select --install

# Change Mac system settings
sh scripts/macos.sh

# Install brew and core applications
sh scripts/brew.sh

# Run vim script
sh scripts/vim.sh

# Run symlinks
sh scripts/symlink-setup.sh

