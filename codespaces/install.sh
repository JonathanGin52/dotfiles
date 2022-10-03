#!/usr/bin/env sh

THISDIR=$(cd "$(dirname "$0")" || exit 1; pwd)
tee < ~/.zshrc -a "${THISDIR}/zshrc"

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
 zsh \
 tmux \
 jq \
 ripgrep \
 fd-find \
 fzf

# Install rdm - https://github.com/BlakeWilliams/remote-development-manager
if ! [ -x "$(command -v rdm)" ]; then
  wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-linux-amd64
  sudo mv rdm-linux-amd64 /usr/local/bin/rdm
  sudo chmod +x /usr/local/bin/rdm
fi

if ! grep -qF "IDEMPOTENCY TOKEN" ~/.zshrc; then
  {
    echo "# IDEMPOTENCY TOKEN"
    # shellcheck disable=2016
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
    echo 'export TERM=xterm-256color'
    echo 'alias vim=nvim'
    echo 'alias pbcopy="rdm copy"'
    echo 'alias pbpaste="rdm paste"'
    echo 'alias open="rdm open"'
    echo 'alias xdg-open="rdm open"'
  } >> ~/.zshrc
fi

sudo chsh -s "$(which zsh)" "$(whoami)"
