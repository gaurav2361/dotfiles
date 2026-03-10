{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.versionControl.git.gh;
in
{
  options.versionControl.git.gh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.versionControl.git.enable;
      description = "Enable GitHub CLI tool (gh)";
    };
  };

  config = lib.mkIf cfg.enable {
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
