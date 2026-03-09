{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.cli.btop;
in
{
  options.cli.btop = {
    enable = lib.mkEnableOption "Btop";
  };
  config = lib.mkIf cfg.enable {
    programs.btop = {
      package = pkgs.btop-cuda;
      enable = true;
    };
    home.file.".config/btop" = {
      recursive = true;
      source = ../config/btop;
    };
  };
}
