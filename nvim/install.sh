#!/usr/bin/env sh
"$(dirname "$0")/../auto-install.sh" "$0"
OS=$("$(dirname "$0")/../os.sh")

# if [ "$OS" = "codespace" ]; then
#   sudo apt install -y fuse libfuse2
#   sudo groupadd fuse
#   sudo usermod -aG fuse "$(whoami)"
#   wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
#   chmod u+x nvim.appimage
#   sudo mv nvim.appimage /usr/local/bin/nvim
# fi
#
# echo "Install/update packer.nvim"
# PACKDIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
# if [ ! -d "$PACKDIR" ]; then
#   git clone --depth 1 https://github.com/wbthomason/packer.nvim\
#    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# fi
# cd "$PACKDIR" || exit 1
# git pull
# echo 

echo "PackerSync"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
