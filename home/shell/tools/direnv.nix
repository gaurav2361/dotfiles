{
  myLib,
  pkgs,
  lib,
  config,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "shell.tools.direnv";
  description = "direnv environment switcher";
  config = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
