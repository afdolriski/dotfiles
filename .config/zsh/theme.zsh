autoload -Uz colors && colors

git_prompt_info() {
  local ref
  ref="$(command git symbolic-ref --short HEAD 2>/dev/null)" \
    || ref="$(command git rev-parse --short HEAD 2>/dev/null)" \
    || return 0
  echo " %{$fg_bold[blue]%}(%{$fg[red]%}${ref}%{$fg_bold[blue]%})%{$reset_color%}"
}

setopt prompt_subst

# 󰀩󰳦

PROMPT="%(?:%{$fg_bold[green]%}%1{󰢚%} :%{$fg_bold[red]%}%1{%} ) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+='$(git_prompt_info) '

autoload -Uz promptinit
promptinit
