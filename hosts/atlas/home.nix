{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ../../home/shell
    ../../home/git
    ../../home/editor
    ../../home/hyprland
    ../../home/waybar
    ../../home/spicetify.nix
    ../../home/vicinae.nix
    ../../home/thunar.nix
    ../../home/ghostty.nix

    ./secrets
  ];

  versionControl.git.enable = true;
  shell = {
    zsh.enable = true;
    tools = {
      starship.enable = true;
      direnv.enable = true;
      fastfetch.enable = true;
      bat.enable = true;
    };
  };
  editors = {
    neovim.enable = true;
  };

  home.username = "gaurav";
  home.homeDirectory = "/home/gaurav";

  home.packages = [ ];
  home.file = { };
  xdg.userDirs = {
    enable = true;
    createDirectories = true; # This is the key part
  };

  # this piece of code is for creating empty directories
  home.activation.createCustomDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.config/sops/age"
    $DRY_RUN_CMD mkdir -p "$HOME/personal"
    $DRY_RUN_CMD mkdir -p "$HOME/personal/media"
    $DRY_RUN_CMD mkdir -p "$HOME/personal/projects"
    $DRY_RUN_CMD mkdir -p "$HOME/personal/playground"
    $DRY_RUN_CMD mkdir -p "$HOME/workspace"
  '';

  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
