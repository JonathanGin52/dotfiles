# Tmux aliases
alias ta='tmux attach -t'
alias tn='tmux new-session -s'
alias tls='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias ssh="TERM=xterm-256color ssh"
alias hgrep='history | grep --color=auto'
alias cleanupds='find . -type f -name "*.DS_Store" -ls -delete'
alias pipup='pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'
alias pip3up='pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U'
alias update_all="sudo softwareupdate --install --all \
  && brew update \
  && brew upgrade \
  && brew cleanup \
  && pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U \
  && npm install -g npm \
  && npm update -g"

