{ pkgs, ... }:
{
  spotidownloader = pkgs.callPackage ./spotidownloader.nix { };
  spotiflac = pkgs.callPackage ./spotiflac.nix { };
}
