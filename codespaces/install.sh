#!/usr/bin/env sh

THISDIR=$(cd "$(dirname "$0")" || exit 1; pwd)
tee < ~/.zshrc -a "${THISDIR}/zshrc"

# Install rdm - https://github.com/BlakeWilliams/remote-development-manager
wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-linux-amd64
sudo mv rdm-linux-amd64 /usr/local/bin/rdm
sudo chmod +x /usr/local/bin/rdm
