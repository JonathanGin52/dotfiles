#!/usr/bin/env sh
"$(dirname "$0")/../auto-install.sh" "$0"

THISDIR=$(cd "$(dirname "$0")" || exit 1; pwd)

ln -sf "${THISDIR}/zshrc" ~/.zshrc

ZSH="$(which zsh 2>/dev/null)"

if [ "$(grep -c zsh /etc/shells)" = "0" ]; then
  echo "Please enter your password to add zsh to available shells"
  echo $ZSH | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$ZSH" ]; then
  echo "Changing shell"
  chsh -s "$(which zsh 2>/dev/null)"
fi

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Installing plugins"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
