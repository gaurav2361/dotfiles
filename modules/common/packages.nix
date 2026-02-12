{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    neovim
    wget
    home-manager
    fd
    bc
    gcc
    git-ignore
    gnumake
    markdown-oxide
    go
    pkg-config
    coreutils
    nodejs_22
    cargo
    nixd
    rustc
    pnpm
  ];
}
