{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.darwin.packages;
in
{
  options.modules.darwin.packages = {
    enable = mkEnableOption "macOS system packages configuration";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      luarocks
      nixpkgs-fmt
      harper
    ];
  };
}
