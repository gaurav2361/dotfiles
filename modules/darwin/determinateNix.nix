{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
lib.mkModule {
  globalConfig = config;
  name = "darwin.determinateNix";
  description = "Determinate Systems Nix installer configuration";
  config = {
    determinateNix = {
      enable = true;
      customSettings = {
        trusted-users = [
          "root"
          "gaurav"
        ];
        download-buffer-size = 262144000;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        accept-flake-config = true;
        substituters = [
          "https://cache.nixos.org?priority=10"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        builders-use-substitutes = true;
        max-jobs = 2;
        fallback = true;
        warn-dirty = false;
      };
      determinateNixd.garbageCollector.strategy = "automatic";
    };
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };
}
