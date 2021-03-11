# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/${USER}/.oh-my-zsh"

# Aliases
alias ta='tmux attach -t'
alias tn='tmux new-session -s'
alias tls='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Rails aliases
alias rdm="rake db:migrate"
alias rdms="rake db:migrate:status"
alias rdr="rake db:rollback"
alias rrg="rails routes | rg"
alias rgm="rails generate migration"

alias ssh="TERM=xterm-256color ssh"
alias hgrep='history | rg --color=auto'
alias weather='http http://v2.wttr.in'
alias cleanupds='find . -type f -name "*.DS_Store" -ls -delete'
alias pipup='pip list --outdated --format=freeze | rg -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'
alias pip3up='pip3 list --outdated --format=freeze | rg -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U'
alias update_all="sudo softwareupdate --install --all \
  && brew update \
  && brew upgrade \
  && brew upgrade --cask --greedy \
  && brew cleanup \
  && pip3 list --outdated --format=freeze | rg -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U \
  && npm install -g npm \
  && npm update -g"

alias vim='nvim'
alias ctags="`brew --prefix`/bin/ctags"

function notify {
  title=${1:-"🎉  Finished! 🎉 "}
  msg=${2:-"Your command is finished!"}
  osascript -e "display notification \"$msg\" with title \"$title\" sound name \"Default\""
}

plugins=(
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

export FZF_DEFAULT_COMMAND="fd --type f -E '*.rbi'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load extra (local) settings
[ -f ~/.zshrclocal ] && source ~/.zshrclocal

# oh-my-zsh
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jonathangin/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jonathangin/Desktop/google-cloud-sdk/completion.zsh.inc'; fi
if [ -e /Users/jonathangin/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jonathangin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
