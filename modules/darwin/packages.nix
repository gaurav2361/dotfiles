{
  pkgs,
  lib,
  ...
}:
lib.myModules.mkModule {
  name = "darwin.packages";
  description = "macOS system packages configuration";
  config = {
    environment.systemPackages = with pkgs; [
      luarocks
      nixpkgs-fmt
      harper
    ];
  };
}
