#!/bin/sh

bindkey '^[w' kill-region

function sesh-sessions-widget() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh sessions ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect "$session"
  }
}
zle -N sesh-sessions-widget

function sesh-zoxide-widget() {
  {
    exec </dev/tty
    exec <&1
    local session
    # -i removed to fix connection string issues
    session=$(sesh list -H -z | fzf --height 40% --reverse --border-label ' sesh zoxide ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect "$session"
  }
}
zle -N sesh-zoxide-widget

# Sesh bindings (this file is sourced from zvm_after_init, so direct bindkey works)
bindkey -M viins '^[f' sesh-zoxide-widget
bindkey -M viins '^[s' sesh-sessions-widget
bindkey -M vicmd '^[f' sesh-zoxide-widget
bindkey -M vicmd '^[s' sesh-sessions-widget
