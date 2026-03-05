#!/bin/sh

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Catppuccin Mocha\""
  alias catt="bat --theme \"Catppuccin Mocha\""
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}



# Direnv hook (cached)
_cached_eval direnv direnv hook zsh

# Base URL for the templates
# NIX_TEMPLATE_URL="https://flakehub.com/f/the-nix-way/dev-templates/*"
NIX_TEMPLATE_URL="github:gaurav2361/templates"

# Initialize the current directory with a template
function nix-init {
  local template="${1:-empty}"
  nix flake init --template "$NIX_TEMPLATE_URL#$template"
  direnv allow
}

# Create a new project with a template
function nix-new {
  local dir="$1"
  local template="${2:-empty}"

  if [[ -z "$dir" ]]; then
    echo "Usage: nix-new <directory> [template]"
    echo "Example: nix-new my-project node"
    return 1
  fi

  if [[ -d "$dir" ]]; then
    echo "Directory \"$dir\" already exists!"
    return 1
  fi

  nix flake new "$dir" --template "$NIX_TEMPLATE_URL#$template"
  cd "$dir"
  direnv allow
}

# ── Git Prompt Helpers ───────────────────────────────────────────────
function parse_git_dirty() {
  local STATUS=''
  if [[ -n $(command git status --porcelain 2> /dev/null | tail -n1) ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    STATUS="$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
  echo "$STATUS"
}

function git_prompt_info() {
  local ref
  if ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
     ref=$(command git rev-parse --short HEAD 2> /dev/null); then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}
