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
      vicinae,
      nix-darwin,
      home-manager,
      determinate,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      ...
    }@inputs:
    let
      overlays = import ./overlays { inherit inputs; };
    in
    {
      formatter = {
        "x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".nixfmt;
        "aarch64-darwin" = nixpkgs.legacyPackages."aarch64-darwin".nixfmt;
      };
      inherit overlays;
      nixosConfigurations = {
        atlas = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs self;
            isNixOS = true;
            isDarwin = false;
          };
          modules = [
            ./hosts/atlas/default.nix
            {
              nixpkgs.overlays = [
                overlays.additions
                overlays.modifications
              ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.users.gaurav = import ./hosts/atlas/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "backup";
            }
          ];
        };

        hades = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs self;
            isNixOS = true;
            isDarwin = false;
          };
          modules = [
            disko.nixosModules.disko
            ./hosts/hades/default.nix
            ./hosts/hades/disko-config.nix
            {
              nixpkgs.overlays = [
                overlays.additions
                overlays.modifications
              ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.users.gaurav = import ./hosts/hades/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
      };

      darwinConfigurations.coffee = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs self;
          isDarwin = true;
          isNixOS = false;
        };
        modules = [
          ./hosts/coffee/default.nix
          {
            nixpkgs.overlays = [
              inputs.brew-nix.overlays.default
              overlays.additions
              overlays.modifications
            ];
          }
          home-manager.darwinModules.home-manager
          determinate.darwinModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "backup";
            home-manager.users.gaurav = {
              imports = [ ./hosts/coffee/home.nix ];
              home.username = "gaurav";
              home.homeDirectory = "/Users/gaurav";
            };
          }
        ];
      };

      homeConfigurations = {
        "gaurav@coffee" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs self; };
          modules = [
            ./hosts/coffee/home.nix
            {
              home.username = "gaurav";
              home.homeDirectory = "/Users/gaurav";
            }
          ];
        };
        "gaurav@atlas" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs self; };
          modules = [
            ./hosts/atlas/home.nix
            {
              home.username = "gaurav";
              home.homeDirectory = "/home/gaurav";
            }
          ];
        };

        "gaurav@hades" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs self; };
          modules = [
            ./hosts/hades/home.nix
            {
              home.username = "gaurav";
              home.homeDirectory = "/home/gaurav";
            }
          ];
        };
      };
    };
}
