{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkModule {
  globalConfig = config;
  name = "nixos.fonts";
  description = "NixOS system fonts";
  config = {
    fonts = {
      packages = with pkgs; [
        roboto
        work-sans
        comic-neue
        source-sans
        comfortaa
        inter
        lato
        lexend
        jost
        dejavu_fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        openmoji-color
        twemoji-color-font
        material-symbols
        libertinus
        (google-fonts.override { fonts = [ "Inter" ]; })
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        nerd-fonts.caskaydia-cove
        nerd-fonts.bigblue-terminal
        nerd-fonts.victor-mono
        nerd-fonts.zed-mono
        nerd-fonts.mononoki
        nerd-fonts.heavy-data
        nerd-fonts.inconsolata
        nerd-fonts.fira-code
        nerd-fonts.meslo-lg
        maple-mono.truetype
        maple-mono.NF-unhinted
      ];
      enableDefaultPackages = false;
    };
  };
}
