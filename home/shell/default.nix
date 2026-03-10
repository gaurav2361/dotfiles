{ lib, config, ... }:
with lib;
let
  cfg = config.shell.tools;
in
{
  options.shell.tools = {
    enable = lib.mkEnableOption "Shell tools ecosystem";
  };

  imports = [
    ./nushell.nix
    ./zsh.nix

    ./tools/fastfetch.nix
    ./tools/atuin.nix
    ./tools/direnv.nix
    ./tools/starship.nix
    ./tools/eza.nix
    ./tools/bat.nix
    ./tools/nh.nix
    ./tools/btop.nix
  ];
}
