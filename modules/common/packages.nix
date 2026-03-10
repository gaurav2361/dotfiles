{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.common.packages;
in
{
  options.modules.common.packages = {
    enable = mkEnableOption "Common software packages";
  };

  config = mkIf cfg.enable {
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
      uv
      go
      pkg-config
      coreutils
      nodejs_22
      python313
      just
      cargo
      nixd
      rustc
      pnpm
    ];
  };
}
