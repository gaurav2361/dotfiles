{ myLib, 
  pkgs,
  lib,
  config,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "versionControl.git.gh";
  description = "Enable GitHub CLI tool (gh)";
  enableDefault = config.versionControl.git.enable;
  config = {
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
      extensions = with pkgs; [
        gh-dash
        gh-notify
        gh-s
        gh-f
      ];
    };
  };
}
