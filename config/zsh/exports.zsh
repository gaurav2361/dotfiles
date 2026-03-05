#!/bin/sh

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# Shell Options
setopt autocd
setopt correct
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst
setopt MENU_COMPLETE
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# Editors & Tools
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"
export TERMINAL="ghostty"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# XDG & Data Dirs
export XDG_CONFIG_HOME="$HOME/.config"
export _ZO_DATA_DIR="$HOME/.config/zoxide"
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
export EZA_CONFIG_DIR="$HOME/.config/eza"
export GOPATH="$HOME/.local/share/go"

# PATH
export PATH="$HOME/.local/bin":$PATH
export PATH=$PATH:/usr/bin
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.docker/bin":$PATH
export PATH="$HOME/.local/nvim-macos-arm64/bin":$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
path=("$PNPM_HOME" $path)

# Nix
export NIX_CONFIG="experimental-features = nix-command flakes"

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# Carapace Theme (Catppuccin Mocha)
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
export CARAPACE_HIGHLIGHT_DESCRIPTION='38;5;243:italic'
export CARAPACE_HIGHLIGHT_FLAG='38;5;116'
export CARAPACE_HIGHLIGHT_FLAGARG='38;5;222'
export CARAPACE_HIGHLIGHT_FLAGMULTIARG='38;5;222'
export CARAPACE_HIGHLIGHT_FLAGNOARG='38;5;147'
export CARAPACE_HIGHLIGHT_DEFAULT='38;5;188'
export CARAPACE_HIGHLIGHT_KEYWORDNEGATIVE='38;5;210'
export CARAPACE_HIGHLIGHT_KEYWORDPOSITIVE='38;5;156'
export CARAPACE_HIGHLIGHT_KEYWORDAMBIGUOUS='38;5;222'
export CARAPACE_HIGHLIGHT_KEYWORDUNKNOWN='38;5;243'
export CARAPACE_HIGHLIGHT_VALUE='38;5;213'

# LS_COLORS (cached: avoids forking vivid every shell)
if [[ -n "${commands[vivid]:-}" ]]; then
  local _vivid_cache="$HOME/.cache/zsh/vivid_ls_colors.zsh"
  if [[ ! -f "$_vivid_cache" || "${commands[vivid]}" -nt "$_vivid_cache" ]]; then
    echo "export LS_COLORS=\"$(vivid generate molokai)\"" > "$_vivid_cache"
  fi
  source "$_vivid_cache"
fi

# macOS-specific
case "$(uname -s)" in
Darwin)
  export DYLD_LIBRARY_PATH=/opt/homebrew/lib/
  export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib
  # Homebrew
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_ENV_HINTS=1
  ;;
esac
