{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../home
  ];

  versionControl.git.enable = true;
  cli.lazydocker.enable = true;
  shell.tools.nh.enable = true;

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
