{ myLib, 
  config,
  lib,
  pkgs,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "cli.lazydocker";
  description = "lazydocker";
  config = {
    programs.lazydocker = {
      enable = true;
    };
  };
}
