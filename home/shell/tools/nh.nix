{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "shell.tools.nh";
  description = "nh Nix helper tools";
  enableDefault = config.shell.tools.enable or false;
  config = {
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
