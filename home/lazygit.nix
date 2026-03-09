{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.cli.lazygit;
in
{
  options.cli.lazygit = {
    enable = lib.mkEnableOption "Lazygit terminal UI for Git";
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit.enable = true;
    home.file.".config/lazygit/config.yml" = {
      source = ../config/lazygit/config.yml;
    };
  };
}
