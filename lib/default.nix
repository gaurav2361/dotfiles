{ inputs }:
let
  baseLib = inputs.nixpkgs.lib;
  configHelper = import ./configHelper.nix { inherit inputs; };
  moduleHelper = import ./moduleHelper.nix { lib = baseLib; };
in
baseLib
// {
  # Merge our system strings into the standard lib.systems
  systems = baseLib.systems // configHelper.systems;

  # Flatten common helpers and metadata
  inherit (configHelper)
    forAllSystems
    standardOverlays
    overlays
    mkNixosHost
    mkDarwinHost
    mkSystem
    mkHomeConfig
    ;

  inherit (moduleHelper)
    mkModule
    mkHomeModule
    mkBoolOpt
    mkStrOpt
    mkPkgOpt
    ;
}
