#!/usr/bin/env sh
THISDIR=$(cd "$(dirname "$0")" || exit 1; pwd)
OS="$("$THISDIR/os.sh")"
DIR="$(cd "$(dirname "${1-}")" || exit 1; pwd)"

if [ -f "$DIR/Brewfile" ] && [ "$OS" = "macos" ]; then
   if ! which brew >/dev/null 2>&1; then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  echo "Installing brew packages..."
  brew bundle install --file="$DIR/Brewfile"
elif [ -f "$DIR/Debfile" ] && [ "$(which apt 2>/dev/null)" ]; then
  echo "Installing deb packages..."
  xargs -a "$DIR/Debfile" sudo apt install -qq -y --no-install-recommends
fi

if [ -d "$DIR/config" ]; then
  echo "Installing config dirs..."
  for DOTDIR in "$DIR/config/"*; do
    XDGDIR="$HOME/.config/$(basename "$DOTDIR")"
    if [ ! -L "$XDGDIR" ] && [ -d "$XDGDIR" ]; then
      MOVEDIR="$XDGDIR.old-$(date -Iseconds)"
      echo "Found old dir, gracefully moving to $MOVEDIR"
      mv -f "$XDGDIR" "$MOVEDIR"
    fi
    ln -sfn "$DOTDIR" "$XDGDIR" 
  done
fi
