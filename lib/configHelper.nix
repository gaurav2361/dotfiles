{ inputs }:
let
  inherit (inputs)
    self
    nixpkgs
    nix-darwin
    home-manager
    ;
  lib = nixpkgs.lib;

  # Supported systems
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  # Helper to generate attributes for all systems
  forAllSystems = lib.genAttrs systems;

  # Standard overlays for all hosts
  standardOverlays = [
    (import ../overlays { inherit inputs; }).additions
    (import ../overlays { inherit inputs; }).modifications
  ];

  # Platform helpers
  isDarwin = system: lib.hasSuffix "darwin" system;

  # Helper to create pkgs with overlays
  mkPkgs =
    system:
    import nixpkgs {
      inherit system;
      inherit (nixpkgs) lib;
      config.allowUnfree = true;
      overlays = standardOverlays ++ (lib.optional (isDarwin system) inputs.brew-nix.overlays.default);
    };

in
{
  inherit systems forAllSystems standardOverlays;

  overlays = import ../overlays { inherit inputs; };

  # Helper for NixOS configurations
  mkNixosHost =
    {
      hostname,
      system ? "x86_64-linux",
      username ? "gaurav",
      extraModules ? [ ],
      extraOverlays ? [ ],
    }:
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs self;
        lib = self.lib; # Pass our custom lib
        isNixOS = true;
        isDarwin = false;
      };

      modules = [
        ../hosts/${hostname}/default.nix
        { nixpkgs.overlays = standardOverlays ++ extraOverlays; }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = {
            imports = [ ../hosts/${hostname}/home.nix ];
            home.username = lib.mkForce username;
            home.homeDirectory = lib.mkForce "/home/${username}";
          };
          home-manager.extraSpecialArgs = { inherit inputs self; };
          home-manager.backupFileExtension = "backup";
        }
      ]
      ++ extraModules;
    };

  # Helper for Darwin configurations
  mkDarwinHost =
    {
      hostname,
      system ? "aarch64-darwin",
      username ? "gaurav",
      extraModules ? [ ],
      extraOverlays ? [ ],
    }:
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit inputs self;
        lib = self.lib; # Pass our custom lib
        isDarwin = true;
        isNixOS = false;
      };

      modules = [
        ../hosts/${hostname}/default.nix
        { nixpkgs.overlays = [ inputs.brew-nix.overlays.default ] ++ standardOverlays ++ extraOverlays; }
        home-manager.darwinModules.home-manager
        inputs.determinate.darwinModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs self; };
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = {
            imports = [ ../hosts/${hostname}/home.nix ];
            home.username = lib.mkForce username;
            home.homeDirectory = lib.mkForce "/Users/${username}";
          };
        }
      ]
      ++ extraModules;
    };

  # Unified System Helper
  mkSystem =
    { hostname, system, ... }@args:
    if isDarwin system then self.lib.mkDarwinHost args else self.lib.mkNixosHost args;

  # Helper for standalone Home Manager configurations
  mkHomeConfig =
    {
      hostname,
      system,
      username ? "gaurav",
      homeDirectory ? null,
      extraModules ? [ ],
    }:
    let
      pkgs = mkPkgs system;
      finalHomeDir =
        if homeDirectory != null then
          homeDirectory
        else if isDarwin system then
          "/Users/${username}"
        else
          "/home/${username}";
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs self; };
      modules = [
        ../hosts/${hostname}/home.nix
        {
          home.username = lib.mkForce username;
          home.homeDirectory = lib.mkForce finalHomeDir;
        }
      ]
      ++ extraModules;
    };
}
