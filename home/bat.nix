{
  pkgs,
  lib,
  ...
}:
{
  programs.bat = {
    enable = true;
    # extraPackages = with pkgs.bat-extras; [
    #   batman
    #   batpipe
    #   batgrep
    # ];
  };
  home.file.".config/bat" = {
    recursive = true;
    source = ../config/bat;
  };
  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
