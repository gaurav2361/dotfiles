{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkHomeModule {
  globalConfig = config;
  name = "cli.lazydocker";
  description = "lazydocker";
  config = {
    programs.lazydocker = {
      enable = true;
    };
  };
}
