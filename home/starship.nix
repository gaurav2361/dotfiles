{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.terminal.starship;
in
{
  options.terminal.starship = {
    enable = lib.mkEnableOption "starship with custom dotfiles symlink";
  };
  config = lib.mkIf cfg.enable {

    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../config/starship.toml;
    };
  };
}
