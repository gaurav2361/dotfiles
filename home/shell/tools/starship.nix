{ myLib, 
  config,
  lib,
  pkgs,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "shell.tools.starship";
  description = "starship with custom dotfiles symlink";
  config = {
    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../../../config/starship.toml;
    };
  };
}
