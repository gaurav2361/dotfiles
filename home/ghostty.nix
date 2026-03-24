{
  myLib,
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "terminal.ghostty";
  description = "ghostty terminal";
  config = {
    home.packages =
      if pkgs.stdenv.isLinux then
        [ inputs.ghostty.packages."${pkgs.stdenv.hostPlatform.system}".default ]
      else
        [ pkgs.brewCasks.ghostty ];

    home.file.".config/ghostty".source = builtins.toString (
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/ghostty"
    );
  };
}
