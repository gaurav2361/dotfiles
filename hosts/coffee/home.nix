{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    spotiflac
    spotidownloader
  ];
  imports = [
    ../../home
    ./secrets
  ];

  lang = {
    rust.enable = true;
    node.enable = true;
    zig.enable = true;
    python.enable = true;
  };
  editors = {
    neovim.enable = true;
    zed.enable = true;
  };

  # These MUST be set for Darwin
  home.username = "gaurav";
  home.homeDirectory = "/Users/gaurav";

  # Disable XDG on macOS
  xdg.userDirs.enable = false;

  # Create directories manually instead
  home.activation.createCustomDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.config/sops/age"
    $DRY_RUN_CMD mkdir -p "$HOME/personal"
    $DRY_RUN_CMD mkdir -p "$HOME/personal/media"
    $DRY_RUN_CMD mkdir -p "$HOME/personal/obsidian"
    $DRY_RUN_CMD mkdir -p "$HOME/personal/projects"
    $DRY_RUN_CMD mkdir -p "$HOME/personal/playground"
    $DRY_RUN_CMD mkdir -p "$HOME/workspace"
    $DRY_RUN_CMD mkdir -p "$HOME/workspace/docs"
  '';

  home.stateVersion = "25.05";
  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    TERM = "ghostty";
    EDITOR = "nvim";
    SHELL = "zsh";
  };
  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
    "$HOME/.cargo/bin"
    "/opt/homebrew/bin"
  ];
  programs.home-manager.enable = true;
}
