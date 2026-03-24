{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkModule {
  globalConfig = config;
  name = "common.packages";
  description = "Common software packages";
  config = {
    environment.systemPackages = with pkgs; [
      vim
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
