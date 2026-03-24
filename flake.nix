{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.brew-api.follows = "brew-api";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    vicinae.url = "github:vicinaehq/vicinae";
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ghostty.url = "github:ghostty-org/ghostty";
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh = {
      url = "github:gaurav2361/nh";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      ...
    }@inputs:
    let
      # Initialize our custom library
      lib = import ./lib { inherit inputs; };
    in
    {
      # Expose lib for use within the flake and by other flakes
      inherit lib;

      # Standard formatter for all supported systems
      formatter = lib.forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      # Common overlays
      inherit (lib) overlays;

      # System configurations
      nixosConfigurations = {
        atlas = lib.mkSystem {
          hostname = "atlas";
          system = lib.systems.x86_64-linux;
        };

        hades = lib.mkSystem {
          hostname = "hades";
          system = lib.systems.x86_64-linux;
          extraModules = [
            disko.nixosModules.disko
            ./hosts/hades/disko-config.nix
          ];
        };

      };

      darwinConfigurations.coffee = lib.mkSystem {
        hostname = "coffee";
        system = lib.systems.aarch64-darwin;
      };

      # Standalone Home Manager configurations
      homeConfigurations = {
        "gaurav@coffee" = lib.mkHomeConfig {
          hostname = "coffee";
          system = lib.systems.aarch64-darwin;
        };
        "gaurav@atlas" = lib.mkHomeConfig {
          hostname = "atlas";
          system = lib.systems.x86_64-linux;
        };
        "gaurav@hades" = lib.mkHomeConfig {
          hostname = "hades";
          system = lib.systems.x86_64-linux;
        };
      };
    };
}
