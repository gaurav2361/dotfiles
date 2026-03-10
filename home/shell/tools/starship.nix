{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.shell.tools.starship;
in
{
  options.shell.tools.starship = {
    enable = lib.mkEnableOption "starship with custom dotfiles symlink";
  };
  config = lib.mkIf cfg.enable {

    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../../../config/starship.toml;
    };
  };
}
