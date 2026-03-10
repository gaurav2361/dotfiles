# Hyprland is a dynamic tiling Wayland compositor.
{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.desktop.hyprland;
in
{
  options.modules.nixos.desktop.hyprland = {
    enable = mkEnableOption "NixOS Hyprland desktop environment";
  };

  config = mkIf cfg.enable {
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
