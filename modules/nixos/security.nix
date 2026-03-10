{ config, lib, ... }:
with lib;
let
  cfg = config.modules.nixos.security;
in
{
  options.modules.nixos.security = {
    enable = mkEnableOption "NixOS basic security settings";
  };

  config = mkIf cfg.enable {
    security = {
      # allow wayland lockers to unlock the screen
      pam.services.hyprlock.text = "auth include login";

      # userland niceness
      rtkit.enable = true;

      # don't ask for password for wheel group
      # sudo.wheelNeedsPassword = false;
    };
  };
}
