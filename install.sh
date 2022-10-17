#!/usr/bin/env bash

SCRIPT_ROOT=$(cd "$(dirname "$0")" || exit 1; pwd)
if [ -d "$SCRIPT_ROOT/setup" ]; then
  SCRIPT_ROOT="$(dirname "${SCRIPT_ROOT}")"
fi
OS=$(${SCRIPT_ROOT}/os.sh)

echo "########################################"
echo "# Running keithamus dotfiles installer"
echo "# \`$SCRIPT_ROOT/install.sh\`"
echo "########################################"

installScript() {
  echo "###"
  echo "# Installing $1"
  echo "###"
  sh "$SCRIPT_ROOT/$2/${3:-install}.sh"
}

if [ "$OS" = "macos" ]; then
  "$THISDIR/homebrew/install.sh"
  brew upgrade && brew upgrade
elif [ -f "$DIR/Debfile" ] && [ "$(which apt 2>/dev/null)" ]; then
  sudo apt update && sudo apt upgrade -y
fi

if [ "$OS" = "codespace" ]; then
  installScript "Codespaces" codespaces
else
  installScript "ZSH" zsh
fi

installScript "Neovim" nvim
installScript "Git" git
installScript "CLI Tools" cli-tools
