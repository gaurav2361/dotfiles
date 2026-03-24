{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  configHelper = import ./configHelper.nix { inherit inputs; };
  moduleHelper = import ./moduleHelper.nix { inherit lib; };
in
lib
// {
  # Merge our system strings into the standard lib.systems
  systems = lib.systems // configHelper.systems;

  # Flatten common helpers
  inherit (configHelper) forAllSystems;

  # Internal Flake Helpers
  flake = {
    inherit (configHelper)
      standardOverlays
      overlays
      ;
  };

  # Flattened Host Creation Helpers
  inherit (configHelper)
    mkNixosHost
    mkDarwinHost
    mkSystem
    mkHomeConfig
    ;

  # Flattened Module Helpers
  inherit (moduleHelper)
    mkModule
    mkBoolOpt
    mkStrOpt
    mkPkgOpt
    ;
}
