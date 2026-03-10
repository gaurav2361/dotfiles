# Nix configuration for NixOS
{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.darwin.nix;
in
{
  options.modules.darwin.nix = {
    enable = mkEnableOption "System Nix configuration";
  };
  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;
    nix = {
      channel.enable = false;
      extraOptions = ''
        warn-dirty = false
      '';
      optimise.automatic = true;
      settings = {
        trusted-users = [
          "root"
          "gaurav"
        ];
        download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        accept-flake-config = true;
        substituters = [
          # high priority since it's almost always used
          "https://cache.nixos.org?priority=10"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        # ADD THESE NEW LINES:
        builders-use-substitutes = true; # Use substitutes when building
        max-jobs = 2; # Don't build anything locally, only download binaries
        fallback = true;
      };
      gc = {
        automatic = true;
        interval = {
          Weekday = 0;
          Hour = 0;
          Minute = 0;
        };
        options = "--delete-older-than 7d";
      };
    };
  };
}
