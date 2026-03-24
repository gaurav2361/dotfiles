{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkHomeModule {
  globalConfig = config;
  name = "versionControl.git.jj";
  description = "Enable Jujutsu (jj) version control system";
  enableDefault = config.versionControl.git.enable;
  config = {
    home.packages = with pkgs; [
      jujutsu
      jjui
    ];
    programs.jujutsu = {
      enable = true;
      package = pkgs.jujutsu;

      # Full options:
      # https://github.com/martinvonz/jj/blob/main/docs/config.md
      # settings = {
      #   inherit (config.programs.git.settings) user;
      # };
    };
  };
}
