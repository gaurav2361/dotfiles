{ inputs }:
let
  configHelper = import ./configHelper.nix { inherit inputs; };
in
{
  # Export everything from configHelper
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

  # You can add more library components here in the future
  # utils = import ./utils.nix { inherit inputs; };
}
