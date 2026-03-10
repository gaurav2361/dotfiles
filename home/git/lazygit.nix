{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.versionControl.git.lazygit;
in
{
  options.versionControl.git.lazygit = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.versionControl.git.enable;
      description = "Enable Lazygit terminal UI for Git";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit.enable = true;
    home.file.".config/lazygit/config.yml" = {
      source = ../../config/lazygit/config.yml;
    };
  };
}
