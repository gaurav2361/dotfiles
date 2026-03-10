{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../home/git
    ../../home/nh.nix
    ../../home/lazydocker.nix
  ];

  versionControl.git.enable = true;

  home.username = "gaurav";
  home.homeDirectory = "/home/gaurav";

  home.packages = [ ];
  home.file = { };

  # Disable XDG for initial install
  xdg.userDirs.enable = false;

  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.stateVersion = "25.05";
}
