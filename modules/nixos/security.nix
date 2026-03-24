{ config, lib, ... }:
lib.mkModule {
  globalConfig = config;
  name = "nixos.security";
  description = "NixOS basic security settings";
  config = {
    security = {
      pam.services.hyprlock.text = "auth include login";
      rtkit.enable = true;
    };
  };
}
