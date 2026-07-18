# Theme colors are loaded by _prompt_load_theme (defined below), which also
# reloads them live when themify switches/refreshes the theme.

# Prevent Python virtualenv from polluting the prompt export VIRTUAL_ENV_DISABLE_PROMPT=1
# No EOL mark for partial lines (Pure used to set this)
PROMPT_EOL_MARK=''

setopt PROMPT_SUBST
# Show the right prompt only on the current line: scrollback stays
# clean and copied lines don't drag the git info along
setopt TRANSIENT_RPROMPT
autoload -Uz vcs_info add-zsh-hook
zmodload zsh/datetime zsh/stat

# ⚛✇࿋✪𖣘𖣐❀󱃋
# ❟❛❟, ⚛✇࿋✪𖣘𖣐
# --- Appearance ----------------------------------------------
PROMPT_SYMBOL="${PROMPT_SYMBOL:-󰢚%} "
PROMPT_SYMBOL_ERROR="${PROMPT_SYMBOL_ERROR:-🐦‍🔥} "

# (Re)load theme colors and rebuild every color-dependent prompt piece. Runs at
# startup and again whenever the theme changes under a running shell (see
# _prompt_theme_watch). PROMPT_*_COLOR stay ANSI names that follow the terminal
# palette; the git-info/exec-time colors and the vcs_info formats bake hex
# values from colors.sh in at definition time, so they must be re-derived here.
_prompt_load_theme() {

	PROMPT_NORMAL_COLOR="${PROMPT_NORMAL_COLOR:-cyan}"
	PROMPT_SUCCESS_COLOR="${PROMPT_SUCCESS_COLOR:-green}"
	PROMPT_ERROR_COLOR="${PROMPT_DANGER_COLOR:-red}"
	PROMPT_WARNING_COLOR="${PROMPT_WARNING_COLOR:-red}"
	GIT_BRANCH_COLOR="${text_muted:-7}"
	GIT_ARROWS_COLOR="${info:-cyan}"
	PROMPT_EXEC_TIME_COLOR="${highlight:-yellow}"

	# vcs_info formats are never re-expanded at render time (see NOTE at the
	# RPS1 setup), so redefine them here every time colors change
	zstyle ':vcs_info:git:*' unstagedstr "%F{$PROMPT_WARNING_COLOR}*%F{$GIT_BRANCH_COLOR}"
	zstyle ':vcs_info:git:*' formats "%F{$GIT_BRANCH_COLOR}%b%u%c%F{$GIT_ARROWS_COLOR}%m%f"
	zstyle ':vcs_info:git:*' actionformats "%F{$GIT_BRANCH_COLOR}%b|%a%u%c%F{$GIT_ARROWS_COLOR}%m%f"
}

_prompt_load_theme

# --- smart path -------------------------------------------
SMART_PATH_LEVEL=3

# smart_path [level] — $PWD with ~ substitution, truncated to at most
# <level> trailing segments (…-prefixed when shortened)
smart_path() {
	local level="${1:-$SMART_PATH_LEVEL}"
	local p="${(D)PWD}"
	local -a parts parts=("${(@s:/:)p}")
	[[ -z "$parts[1]" ]] && parts=("${(@)parts[2,-1]}")
	if (( ${#parts} <= level )); then
		print -rn -- "$p"
	else
		print -rn -- "…/${(@j:/:)parts[-level,-1]}"
	fi
}

autoload -Uz colors && colors

PS1=''
PS1+="%(?:%{$fg_bold[green]%}%1{󰢚%} :%{$fg_bold[red]%}%1{%} ) %{$fg[cyan]%}%c%{$reset_color%} "

# --- right prompt: pluggable info segments ----------------
# NOTE: unlike PS1, vcs_info format strings are never parameter-expanded at
# render time — color variables must be baked in with double quotes, or %F{}
# receives the literal '$VAR' text and renders nothing. Because they're baked,
# the colored formats (unstagedstr/formats/actionformats) live in
# _prompt_load_theme so a theme reload rebuilds them; only the color-independent
# settings stay here.
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git*+set-message:*' hooks git-arrows
add-zsh-hook precmd vcs_info

# The ⇣ arrow only moves when the remote-tracking ref moves, so fetch
# in the background at most once per interval (seconds; 0 disables).
# The result shows on the next prompt.
PROMPT_GIT_FETCH_INTERVAL=300

_prompt_git_fetch() {
	(( PROMPT_GIT_FETCH_INTERVAL )) || return 0
	local gitdir
	gitdir=$(command git rev-parse --git-dir 2>/dev/null) || return 0
	command git rev-parse --abbrev-ref '@{upstream}' >/dev/null 2>&1 || return 0
	local stamp="$gitdir/.prompt-fetch-stamp" last=0
	[[ -f "$stamp" ]] && last=$(<"$stamp")
	(( EPOCHSECONDS - last < PROMPT_GIT_FETCH_INTERVAL )) && return 0
	print -n -- "$EPOCHSECONDS" >| "$stamp"
	( GIT_TERMINAL_PROMPT=0 command git -c gc.auto=0 fetch --quiet --no-tags >/dev/null 2>&1 &| )
}
add-zsh-hook precmd _prompt_git_fetch

# %m: ⇡ commits not pushed to upstream, ⇣ commits not pulled from it
+vi-git-arrows() {
	local -a counts arrows
	counts=($(command git rev-list --left-right --count 'HEAD...@{upstream}' -- 2>/dev/null)) || return 0
	(( counts[1] )) && arrows+=('⇡')
	(( counts[2] )) && arrows+=('⇣')
	hook_com[misc]="${(j::)arrows}"
}

git_info() {
	print -rn -- "$vcs_info_msg_0_"
}

# --- execution time segment --------------------------------
# Shown when the last command ran at least this many seconds (0 = always)
PROMPT_EXEC_TIME_THRESHOLD=5
# PROMPT_EXEC_TIME_COLOR is theme-dependent — derived in _prompt_load_theme

_prompt_exec_preexec() {
	_prompt_exec_start=$EPOCHREALTIME
}
add-zsh-hook preexec _prompt_exec_preexec

_prompt_exec_precmd() {
	if [[ -n "$_prompt_exec_start" ]]; then
		_prompt_exec_elapsed=$(( EPOCHREALTIME - _prompt_exec_start ))
		unset _prompt_exec_start
	else
		# plain Enter, Ctrl+C on an empty line, etc: nothing ran
		_prompt_exec_elapsed=''
	fi
}
add-zsh-hook precmd _prompt_exec_precmd

_prompt_format_duration() {
	local -i s=$1
	local out=''
	(( s >= 3600 )) && out+="$(( s / 3600 ))h "
	(( s >= 60 )) && out+="$(( s % 3600 / 60 ))m "
	out+="$(( s % 60 ))s"
	print -rn -- "$out"
}

execution_time() {
	[[ -n "$_prompt_exec_elapsed" ]] || return 0
	local -i elapsed=$(( _prompt_exec_elapsed ))
	(( elapsed >= PROMPT_EXEC_TIME_THRESHOLD )) || return 0
	print -rn -- "%F{$PROMPT_EXEC_TIME_COLOR}󱎫$(_prompt_format_duration $elapsed)%f"
}

# Add segments here: each is a function that prints one chunk
# (empty output is skipped), joined with two spaces in RPS1
prompt_info_segments=(git_info execution_time)

# Rendered when every segment is empty, so the right side never
# collapses and the two-line composition keeps its proportion
PROMPT_INFO_FALLBACK="%F{$GIT_BRANCH_COLOR}·%f"

prompt_info() {
	local seg out
	local -a parts
	for seg in "${prompt_info_segments[@]}"; do
		out="$($seg)"
		[[ -n "$out" ]] && parts+=("$out")
	done
	if (( ${#parts} )); then
		print -rn -- "${(j:  :)parts}"
	else
		print -rn -- "$PROMPT_INFO_FALLBACK"
	fi
}

RPS1='$(prompt_info)'
