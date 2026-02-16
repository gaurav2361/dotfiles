{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../home/tmux.nix
    ../../home/zsh.nix
    # ../../home/nushell.nix
    # ../../home/zen
    # ../../home/zen.nix
    ../../home/direnv.nix
    ../../home/starship.nix
    ../../home/nh.nix
    ../../home/btop.nix
    ../../home/git.nix
    ../../home/lazygit.nix
    ../../home/gh.nix
    ../../home/jujutsu.nix
    ../../home/lazydocker.nix
    ../../home/editor/neovim.nix
    ../../home/editor/zed.nix
    ../../home/fastfetch.nix
    ../../home/bat.nix
    ../../home/node.nix
    ../../home/rust.nix
    # ../../home/zig.nix
    ../../home/ghostty.nix
    ../../home/atuin.nix
    ../../home/aerospace.nix
    ../../home/mpv.nix
    ../../home/spicetify.nix

    ./secrets
  ];

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
    # SHELL = "${pkgs.nushell}/bin/nu";
  };
  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
    "$HOME/.cargo/bin"
    "/opt/homebrew/bin"
  ];
  programs.home-manager.enable = true;
}
