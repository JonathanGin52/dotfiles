#!/usr/bin/env sh
"$(dirname "$0")/../auto-install.sh" "$0"

if [ "$(which apt 2>/dev/null)" ]; then
  # Git-Delta
  wget -q https://github.com/dandavison/delta/releases/download/0.14.0/git-delta_0.14.0_amd64.deb
  sudo dpkg --skip-same-version -i git-delta_0.14.0_amd64.deb
  rm -f git-delta_0.14.0_amd64.deb
fi

GITEDITOR="$(git config --global core.editor)"
GITNAME="$(git config --global user.name)"
GITEMAIL="$(git config --global user.email)"
THISDIR=$(cd "$(dirname "$0")" || exit 1; pwd)
GITCONFIG="$THISDIR/gitconfig"

mkdir -p ~/.config/git
git config --global core.editor "${GITEDITOR:-nvim}"
git config --global user.name "${GITNAME:-Jonathan Gin}"
git config --global user.email "${GITEMAIL:-jonathangin52@github.com}"
git config --global include.path "$GITCONFIG"
