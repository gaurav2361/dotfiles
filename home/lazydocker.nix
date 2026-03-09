{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.cli.lazydocker;
in
{
  options.cli.lazydocker = {
    enable = lib.mkEnableOption "lazydocker";
  };
  config = lib.mkIf cfg.enable {
    programs.lazydocker = {
      enable = true;
    };
  };
}
