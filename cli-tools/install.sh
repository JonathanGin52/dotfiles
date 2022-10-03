#!/usr/bin/env sh
"$(dirname "$0")/../auto-install.sh" "$0"

if ! [ -x "$(command -v rdm)" ]; then
  wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-linux-amd64
  sudo mv rdm-linux-amd64 /usr/local/bin/rdm
  sudo chmod +x /usr/local/bin/rdm
fi
