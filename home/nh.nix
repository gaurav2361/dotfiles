{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.cli.nh;
in
{
  options.cli.nh = {
    enable = lib.mkEnableOption "Zed Editor with custom dotfiles symlink";
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
