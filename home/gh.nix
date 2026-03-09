{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.cli.gh;
in
{
  options.cli.gh = {
    enable = lib.mkEnableOption "GitHub CLI tool (gh)";
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
