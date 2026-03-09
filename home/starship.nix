{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cli.starship;
in
{
  options.cli.starship = {
    enable = lib.mkEnableOption "starship with custom dotfiles symlink";
  };
  config = lib.mkIf cfg.enable {

    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../config/starship.toml;
    };
  };
}
