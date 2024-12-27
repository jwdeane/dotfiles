#!/usr/bin/env bash

source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# fzf catppuccin colours https://github.com/catppuccin/fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
# use fd for listing paths
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
# use fd to generate list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
# fzf previews for cd/env/**
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
  export | unset) fzf --preview "eval 'echo \$' {}" ;;
  *) fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;
  esac
}
