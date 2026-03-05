#!/bin/zsh
# Override pnpm script completion to fix script name matching
# This must be sourced AFTER zsh-pnpm-completions plugin loads

_pnpm_get_scripts_from_package_json(){
  local pj="$(_pnpm_recursively_look_for package.json)"
  [[ -z "$pj" ]] && return
  local -a s
  s=(${(f)"$(_pnpm_get_package_json_property_object_keys "$pj" scripts)"})
  compadd -M "r:|:=* r:|=*" -a s
}
