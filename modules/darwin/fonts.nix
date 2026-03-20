{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.darwin.fonts;
in
{
  options.modules.darwin.fonts = {
    enable = mkEnableOption "macOS system fonts configuration";
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        roboto
        work-sans
        comic-neue
        inter
        lato
        (google-fonts.override { fonts = [ "Inter" ]; })
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        nerd-fonts.zed-mono
      ];

      # enableDefaultPackages = false;
    };
  };
}
