#!/bin/sh

# Zinit bootstrap 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone --depth=2 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Should be called before compinit
zmodload zsh/complist

# Catppuccin theme (must be sourced BEFORE syntax-highlighting loads)
source "$HOME/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"

# Source config modules 
source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/functions.zsh"

# Synchronous plugins (needed at prompt-draw time) 
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-autosuggestions

# Turbo-loaded plugins (deferred, non-blocking) 
export ZSH_PNPM_NO_ALIASES="true"
zinit wait lucid for \
    Aloxaf/fzf-tab \
    hlissner/zsh-autopair \
  atload'zicompinit; zicdreplay; source <(carapace _carapace); source ~/.local/share/zinit/plugins/michakfromparis---zsh-pnpm-completions/zsh-pnpm-completions.plugin.zsh; _pnpm_get_scripts_from_package_json(){ local pj="$(_pnpm_recursively_look_for package.json)"; [[ -z "$pj" ]] && return; local -a s; s=(${(f)"$(_pnpm_get_package_json_property_object_keys "$pj" scripts)"}); compadd -M "r:|:=* r:|=*" -a s }' blockf \
    zsh-users/zsh-completions \
    zsh-users/zsh-syntax-highlighting \
  atload'bindkey "^[[A" history-substring-search-up; bindkey "^[[B" history-substring-search-down; bindkey "^p" history-search-backward; bindkey "^n" history-search-forward' \
    zsh-users/zsh-history-substring-search \
    zdharma-continuum/history-search-multi-word

# Keybindings 
# Atuin bindings (must be in array BEFORE vi-mode init runs)
zvm_after_init_commands+=('bindkey -M viins "^k" atuin-up-search')
zvm_after_init_commands+=('bindkey -M vicmd "^k" atuin-up-search')
zvm_after_init_commands+=('bindkey -M viins "^r" atuin-search')
zvm_after_init_commands+=('bindkey -M vicmd "^r" atuin-search')
# Source remaining keybindings after vi-mode is ready
zvm_after_init_commands+=('source "$HOME/.config/zsh/Keybindings.zsh"')
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# zstyle (completion styling) 
source "$HOME/.config/zsh/zstyle.zsh"

# Shell options 
setopt no_nomatch  # Prevent Zsh from throwing errors on unmatched globs

# Init cache for heavy eval tools
# Writes static cache files so we avoid fork+exec on every startup.
typeset -g ZSH_CACHE_DIR="$HOME/.cache/zsh"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"

function _cached_eval {
  local name=$1; shift
  local cache_file="$ZSH_CACHE_DIR/$name.zsh"
  local bin_path="${commands[$1]:-}"

  # Rebuild cache if missing or if the binary is newer
  if [[ ! -f "$cache_file" ]] || [[ -n "$bin_path" && "$bin_path" -nt "$cache_file" ]]; then
    "$@" > "$cache_file" 2>/dev/null
  fi
  source "$cache_file"
}

# Native Prompt
autoload -U colors && colors
setopt prompt_subst

PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Shell integrations
_cached_eval fzf fzf --zsh
_cached_eval zoxide zoxide init --cmd cd zsh
_cached_eval atuin atuin init zsh --disable-up-arrow


