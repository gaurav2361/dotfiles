{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  configHelper = import ./configHelper.nix { inherit inputs; };
  moduleHelper = import ./moduleHelper.nix { inherit lib; };
in
lib
// {
  # Flake metadata and internal helpers
  flake = {
    inherit (configHelper)
      systems
      forAllSystems
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
