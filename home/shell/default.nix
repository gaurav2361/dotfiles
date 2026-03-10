{ ... }:
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
