{
  myLib,
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
myLib.mkHomeModule {
  globalConfig = config;
  name = "media.spicetify";
  description = "Spotify client customizer (Linux only)";
  config = lib.mkIf pkgs.stdenv.isLinux {
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        shuffle
        keyboardShortcut
      ];
    };
  };
}
// {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
}
