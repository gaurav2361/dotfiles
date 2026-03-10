{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.shell.tools.btop;
in
{
  options.shell.tools.btop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.shell.tools.enable;
      description = "Btop system monitor";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.btop = {
      package = pkgs.btop-cuda;
      enable = true;
    };
    home.file.".config/btop" = {
      recursive = true;
      source = ../../../config/btop;
    };
  };
}
