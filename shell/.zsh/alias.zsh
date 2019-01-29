alias hgrep='history | grep --color=auto'
alias pipup='pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'
alias pip3up='pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U'

# Recursively remove .DS_Store files
alias cleanupds='find . -type f -name '*.DS_Store' -ls -delete'

