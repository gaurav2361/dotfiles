{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
lib.mkModule {
  globalConfig = config;
  name = "nixos.desktop.hyprland";
  description = "NixOS Hyprland desktop environment";
  config = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    services.displayManager.defaultSession = "hyprland";
  };
}
