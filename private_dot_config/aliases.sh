alias ealias="$EDITOR ~/.local/share/chezmoi/private_dot_config/aliases.sh"
alias salias="chezmoi apply && source ~/.config/aliases.sh"
# chezmoi
alias cza="chezmoi apply"
alias czav="chezmoi apply --verbose"
# General
alias j="just -f ~/.config/Justfile"
alias vim="nvim"
alias t="tree -L"
# eza /ls
alias l="eza"
alias ll="eza -l --icons --git -a"
alias lla="ls -lah"
# Python
alias py="python"
alias pym="python -m"
alias pyv="python -m venv .venv"
alias pya="source .venv/bin/activate"
alias pyp="python -m pip"
alias pup="python -m pip install --upgrade pip"
alias pfr="python -m pip freeze > requirements.txt"
# Python.poetry
alias poetry-venv-config="poetry config virtualenvs.in-project true"
# Rclone
alias r2="rclone"
alias r2l="rclone ls"
alias r2t="rclone tree"
alias r2up="rclone copyto"
# HTTPie
alias https="https --verify $HOME/.certificates/Cloudflare_CA.pem"
# Digital Ocean
alias drops="doctl compute droplet list"
# GitHub Copilot
alias ghce="gh copilot explain"
alias ghcs="gh copilot suggest"
# Tailscale
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
# Cloudflare
alias zid="j get-zone-id"
