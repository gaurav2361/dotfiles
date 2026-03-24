{ lib, config, ... }:
{
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
// lib.mkHomeModule {
  globalConfig = config;
  name = "shell.tools";
  description = "Shell tools ecosystem";
  config = {}; # No actual config payload here, it just defines the option for the submodules to reference.
}
