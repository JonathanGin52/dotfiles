#!/bin/bash

# Source utils files
source 'scripts/utils.sh'

# Get admin privileges upfront
ask_for_sudo

# Install xcode cli tools
if !(type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d "${xpath}" && test -x "${xpath}"); then
  echo "Install xcode command line tools..."
  xcode-select --install
fi

# Check for Homebrew and install if it's not installed
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Change Mac system settings
ask_for_confirmation "Apply default MacOS preferences from macos.sh?"
if answer_is_yes; then
  sh scripts/macos.sh
  print_success "Successfully applied default MacOS preferences."
else
  print_warning "Skipped MacOS preferences."
fi

# Install brew and core applications
ask_for_confirmation "Run brew script?"
if answer_is_yes; then
  sh scripts/brew.sh
  print_success "Successfully installed brew packages."
else
  print_error "Skipped installing brew packages."
fi

# Setup shell config
ask_for_confirmation "Setup shell?"
if answer_is_yes; then
  sh scripts/zsh.sh
  print_success "Setup shell."
fi

# Run symlinks
ask_for_confirmation "Run symlink setup?"
if answer_is_yes; then
  sh scripts/symlink-setup.sh
  print_success "Completed symlink setup."
else
  print_error "Symlink setup not completed"
fi

# Install vim plugins
ask_for_confirmation "Install Vim plugins?"
if answer_is_yes; then
  sh scripts/vim.sh
  print_success "Finished installing vim plugins."
else
  print_error "Vim plugins not installed, to complete setup, run \"$ vim +PlugInstall +qa\""
fi

