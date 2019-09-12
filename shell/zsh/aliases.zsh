# Tmux aliases
alias ta='tmux attach -t'
alias tn='tmux new-session -s'
alias tls='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Rails aliases
alias rdm="rake db:migrate"
alias rdms="rake db:migrate:status"
alias rdr="rake db:rollback"
alias rrg="rake routes | grep"
alias rgm="rails generate migration"

alias ssh="TERM=xterm-256color ssh"
alias hgrep='history | rg --color=auto'
alias weather='curl http://v2.wttr.in'
alias cleanupds='find . -type f -name "*.DS_Store" -ls -delete'
alias pipup='pip list --outdated --format=freeze | rg -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'
alias pip3up='pip3 list --outdated --format=freeze | rg -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U'
alias update_all="sudo softwareupdate --install --all \
  && brew update \
  && brew upgrade \
  && brew cask upgrade --greedy \
  && brew cleanup \
  && rustup update \
  && pip3 list --outdated --format=freeze | rg -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U \
  && npm install -g npm \
  && npm update -g"

