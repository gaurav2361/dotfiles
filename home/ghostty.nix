{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib;
let
  config_name = if pkgs.stdenv.isLinux then "linux-config" else "mac-config";
  cfg = config.terminal.ghostty;
in
{
  options.terminal.ghostty = {
    enable = lib.mkEnableOption "ghostty terminal";
  };
  config = lib.mkIf cfg.enable {
    home.packages =
      if pkgs.stdenv.isLinux then
        [ inputs.ghostty.packages."${pkgs.stdenv.hostPlatform.system}".default ]
      else
        [ pkgs.brewCasks.ghostty ];

    home.file.".config/ghostty".source = builtins.toString (
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/ghostty"
    );
  };
}
