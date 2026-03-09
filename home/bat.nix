{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.cli.bat;
in
{
  options.cli.bat = {
    enable = lib.mkEnableOption "Bat cat clone with syntax highlighting";
  };
  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };
    home.file.".config/bat" = {
      recursive = true;
      source = ../config/bat;
    };
    home.sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
  };
}
