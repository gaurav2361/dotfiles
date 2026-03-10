{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    # Comment out git for now to test
    # ../../home/git.nix
    ../../home/nh.nix
    ../../home/lazydocker.nix
    ../../home/gh.nix
  ];

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
