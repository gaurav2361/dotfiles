{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  configHelper = import ./configHelper.nix { inherit inputs; };
  moduleHelper = import ./moduleHelper.nix { inherit lib; };
in
lib
// {
  # Renamed to avoid collision with lib.config and lib.modules
  myLib = {
    inherit (configHelper)
      systems
      forAllSystems
      standardOverlays
      overlays
      mkNixosHost
      mkDarwinHost
      mkSystem
      mkHomeConfig
      ;
  };

  myModules = {
    inherit (moduleHelper)
      mkModule
      mkBoolOpt
      mkStrOpt
      mkPkgOpt
      ;
  };
}
