{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkModule {
  globalConfig = config;
  name = "nixos.desktop.gnome";
  description = "NixOS GNOME desktop environment";
  config = {
    services.xserver.enable = true;
    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      gnome.games.enable = true;
    };
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
    environment.systemPackages = with pkgs; [
      gnome-extension-manager
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.compact-top-bar
      gnomeExtensions.custom-accent-colors
      gradience
      gnomeExtensions.tray-icons-reloaded
      gnome-tweaks
      gnomeExtensions.just-perfection
      gnomeExtensions.rounded-window-corners-reborn
      gnomeExtensions.vitals
    ];
    environment.gnome.excludePackages = with pkgs; [
      gnome-maps
      gnome-music
      gnome-tour
      gnome-weather
      geary
      gnome-taquin
      gnome-chess
      gnome-contacts
      gnome-text-editor
      gnome-user-docs
      gnome-tetravex
      gnome-mahjongg
      hitori
      four-in-a-row
      five-or-more
      swell-foop
      gnome-nibbles
      quadrapassel
      tali
      atomix
      gnome-2048
      gnome-klotski
      gnome-sudoku
      gnome-robots
      gnome-mines
    ];
  };
}
