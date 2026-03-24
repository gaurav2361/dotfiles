{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkHomeModule {
  globalConfig = config;
  name = "versionControl.git.lazygit";
  description = "Enable Lazygit terminal UI for Git";
  enableDefault = config.versionControl.git.enable;
  config = {
    programs.lazygit.enable = true;
    home.file.".config/lazygit/config.yml" = {
      source = ../../config/lazygit/config.yml;
    };
  };
}
