#!/bin/sh

# History Configuration
HISTFILE=~/.zsh_history # Use this path consistently
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase

# History options
setopt APPEND_HISTORY             # Append history to the file
setopt SHARE_HISTORY              # Share history across all sessions
setopt HIST_IGNORE_SPACE          # Ignore commands that start with a space
setopt HIST_IGNORE_DUPS           # Ignore duplicate commands
setopt INC_APPEND_HISTORY         # Write history incrementally to the file
setopt HIST_SAVE_NO_DUPS          # Do not save duplicate entries in the history file
setopt HIST_FIND_NO_DUPS          # Do not display duplicate commands in history searches
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

# setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# export EDITOR="nvim"
export EDITOR="nvim visudo"
export VISUAL="nvim visudo"
export SUDO_EDITOR="nvim"
export TERMINAL="ghostty"
# export BROWSER="zen-browser"
# export BROWSER="zen"
export XDG_CONFIG_HOME="$HOME/.config"
export _ZO_DATA_DIR="$HOME/.config/zoxide"
export PATH="$HOME/.local/bin":$PATH
export PATH=$PATH:/usr/bin
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.docker/bin":$PATH
export PATH="$HOME/.local/nvim-macos-arm64/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export GOPATH=$HOME/.local/share/go
export EZA_CONFIG_DIR=$HOME/.config/eza
export PATH="$HOME/.local/share/neovim/bin":$PATH
export XDG_CURRENT_DESKTOP="Wayland"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
# Open in tmux popup if on tmux, otherwise use --height mode
# export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"


# Carapace Catppuccin Mocha Theme
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

export NIX_CONFIG="experimental-features = nix-command flakes"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
export LS_COLORS="$(vivid generate molokai)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
  export DYLD_LIBRARY_PATH=/opt/homebrew/lib/
  export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib
	;;

Linux)
	;;
esac
