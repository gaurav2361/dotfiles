{
  myLib,
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
}
// myLib.mkHomeModule {
  globalConfig = config;
  name = "media.spicetify";
  description = "Spicetify Spotify client customizer";
  config = {
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
