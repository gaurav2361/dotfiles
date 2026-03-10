# Nix configuration for NixOS
{
  config,
  inputs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.nix;
in
{
  options.modules.nixos.nix = {
    enable = mkEnableOption "NixOS package manager subsystem";
  };

  config = mkIf cfg.enable {
    # Allow unfree packages
    nixpkgs.config.allowBroken = true;
    nix = {
      channel.enable = false;
      extraOptions = ''
        warn-dirty = false
      '';
      optimise.automatic = true;
      settings = {
        download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
        # auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          # high priority since it's almost always used
          "https://cache.nixos.org?priority=10"
          "https://nix-community.cachix.org"
          "https://numtide.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        ];
        extra-substituters = [ "https://vicinae.cachix.org" ];
        extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];

        # ADD THESE NEW LINES:
        builders-use-substitutes = true; # Use substitutes when building
        max-jobs = 2; # Don't build anything locally, only download binaries
        fallback = true;
      };
      gc = {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 3d";
      };
    };
  };
}
