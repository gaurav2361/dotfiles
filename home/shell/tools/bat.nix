{ myLib, 
  pkgs,
  lib,
  config,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "shell.tools.bat";
  description = "Bat cat clone with syntax highlighting";
  enableDefault = config.shell.tools.enable or false;
  config = {
    programs.bat = {
      enable = true;
    };
    home.file.".config/bat" = {
      recursive = true;
      source = ../../../config/bat;
    };
    home.sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
  };
}
