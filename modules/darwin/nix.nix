{
  inputs,
  config,
  lib,
  ...
}:
lib.mkModule {
  globalConfig = config;
  name = "darwin.nix";
  description = "System Nix configuration";
  config = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;
    nix = {
      channel.enable = false;
      extraOptions = "warn-dirty = false";
      optimise.automatic = true;
      settings = {
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
