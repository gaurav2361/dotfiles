{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.cli.jujutsu;
in
{
  options.cli.jujutsu = {
    enable = lib.mkEnableOption "Jujutsu (jj) version control system";
  };

  config = lib.mkIf cfg.enable {
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
