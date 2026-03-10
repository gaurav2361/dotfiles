{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.shell.tools.direnv;
in
{
  options.shell.tools.direnv = {
    enable = lib.mkEnableOption "direnv environment switcher";
  };
  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
    # Optional: Uncomment if you want custom cache paths
    # home.sessionVariables = {
    #   DIRENV_DIR = "/tmp/direnv";
    #   DIRENV_CACHE = "/tmp/direnv-cache";
    # };
  };
}
