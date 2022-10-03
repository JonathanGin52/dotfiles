#!/usr/bin/env sh
"$(dirname "$0")/../auto-install.sh" "$0"

# echo "Install/update packer.nvim"
# PACKDIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
# if [ ! -d "$PACKDIR" ]; then
#   git clone --depth 1 https://github.com/wbthomason/packer.nvim\
#    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# fi
# cd "$PACKDIR" || exit 1
# git pull
# echo 
# 
# echo "PackerSync"
# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerSync'
