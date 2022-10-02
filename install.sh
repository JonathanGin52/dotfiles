#!/bin/sh

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
 zsh \
 tmux \
 jq \
 ripgrep \
 fd-find \
 fzf

# Install latest neovim release
# sudo apt-get install -y fuse
# wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# chmod u+x $(pwd)/nvim.appimage
# sudo mv $(pwd)/nvim.appimage /usr/local/bin/nvim

ln -sf $(pwd)/home/tmux.conf $HOME/.tmux.conf
ln -sf $(pwd)/home/gitconfig $HOME/.gitconfig
ln -sf $(pwd)/home/config/nvim $HOME/.config/nvim

# ln -s $(pwd)/home/.zshrc $HOME/.zshrc

# Install rdm
wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-linux-amd64
sudo mv rdm-linux-amd64 /usr/local/bin/rdm
sudo chmod +x /usr/local/bin/rdm

echo "export TERM=xterm-256color" >> $HOME/.zshrc
echo "alias vim=nvim" >> $HOME/.zshrc
echo 'alias pbcopy="rdm copy' >> $HOME/.zshrc
echo 'alias pbpaste="rdm paste' >> $HOME/.zshrc
echo 'export PATH="/workspaces/github/bin:$PATH' >> $HOME/.zshrc

echo 'alias open="rdm open"' >> $HOME/.zshenv
echo 'alias xdg-open="rdm open"' >> $HOME/.zshenv
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

curl -s https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info > /tmp/alacritty.info
sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info

sudo chsh -s "$(which zsh)" "$(whoami)"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
