{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.shell.tools.nh;
in
{
  options.shell.tools.nh = {
    enable = lib.mkEnableOption "nh Nix helper tools";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
      flake = "${config.home.homeDirectory}/dotfiles";
    };
  };
}
