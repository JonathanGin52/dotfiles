#!/usr/bin/env sh

# Install rdm - https://github.com/BlakeWilliams/remote-development-manager
if ! [ -x "$(command -v rdm)" ]; then
  wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-linux-amd64
  sudo mv rdm-linux-amd64 /usr/local/bin/rdm
  sudo chmod +x /usr/local/bin/rdm
fi

if ! grep -qF "IDEMPOTENCY TOKEN" ~/.zshrc; then
  {
    echo "# IDEMPOTENCY TOKEN"
    echo 'plugins+=(z)'
    # shellcheck disable=2016
    echo 'export PATH="$PATH:/workspaces/github/bin"'
    # shellcheck disable=2016
    echo 'export TERM=xterm-256color'
    echo 'alias vim=nvim'
    echo 'alias pbcopy="rdm copy"'
    echo 'alias pbpaste="rdm paste"'
    echo 'alias open="rdm open"'
    echo 'alias xdg-open="rdm open"'
    echo 'source /usr/share/doc/fzf/examples/key-bindings.zsh'
  } >> "$HOME/.zshrc"
fi

sudo chsh -s "$(which zsh)" "$(whoami)"

# Install NeoVim
# Fuse is a dependency to extract appimage
sudo apt-get install -y fuse
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
