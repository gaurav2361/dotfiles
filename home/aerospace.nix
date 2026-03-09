{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.wm.aerospace;
in
{
  options.wm.aerospace = {
    enable = lib.mkEnableOption "AeroSpace macos tiling window manager";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      autoraise
    ];
    programs.aerospace = {
      enable = true;
      launchd.enable = true;
      settings = pkgs.lib.importTOML ../config/aerospace/aerospace.toml;
    };
    # home.file.".config/aerospace/aerospace.toml" = {
    #   source = ../config/aerospace/aerospace.toml;
    # };
  };
}
