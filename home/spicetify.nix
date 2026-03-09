# Spicetify is a spotify client customizer
{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.media.spicetify;
in
{
  options.media.spicetify = {
    enable = lib.mkEnableOption "Spicetify Spotify client customizer";
  };

  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  config = lib.mkIf cfg.enable {
    # Spicetify-nix will install Spotify automatically on all platforms
    home.packages = [ ];

    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;
        theme = spicePkgs.themes.text;
        colorScheme = "TokyoNight";

        enabledExtensions = with spicePkgs.extensions; [
          # adblock
          shuffle # shuffle+ (special characters  sanitized out of ext names)
          keyboardShortcut # vimium-like navigation
          volumePercentage
        ];

        # Uncomment and customize as needed:
        enabledCustomApps = with spicePkgs.apps; [
          lyricsPlus
          localFiles
          ncsVisualizer
          historyInSidebar
          betterLibrary
        ];
      };
  };
}
