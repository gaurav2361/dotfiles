{ myLib, 
  pkgs,
  lib,
  config,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "wm.aerospace";
  description = "AeroSpace macos tiling window manager";
  config = {
    home.packages = with pkgs; [
      autoraise
    ];
    programs.aerospace = {
      enable = true;
      launchd.enable = true;
      settings = pkgs.lib.importTOML ../config/aerospace/aerospace.toml;
    };
  };
}
