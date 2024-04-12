#!/usr/bin/env sh
"$(dirname "$0")/../auto-install.sh" "$0"

if [ "$(uname)" = "Darwin" ]; then
  # Check if running on macOS
  if [ "$(which brew 2>/dev/null)" ]; then
    # Install Git-Delta using Homebrew
    brew install git-delta
  else
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
  fi
elif [ "$(which apt 2>/dev/null)" ]; then
  # Check if apt is available (Ubuntu/Debian)
  wget -q https://github.com/dandavison/delta/releases/download/0.14.0/git-delta_0.14.0_amd64.deb
  sudo dpkg --skip-same-version -i git-delta_0.14.0_amd64.deb
  rm -f git-delta_0.14.0_amd64.deb
else
  echo "Unsupported package manager. Cannot install Git-Delta."
  exit 1
fi

GITEDITOR="$(git config --global core.editor)"
GITNAME="$(git config --global user.name)"
THISDIR=$(cd "$(dirname "$0")" || exit 1; pwd)
GITCONFIG="$THISDIR/gitconfig"

mkdir -p ~/.config/git
git config --global core.editor "${GITEDITOR:-nvim}"
git config --global user.name "${GITNAME:-Jonathan Gin}"
git config --global include.path "$GITCONFIG"
