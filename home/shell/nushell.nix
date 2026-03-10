{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.shell.nushell;
  nu-scripts = pkgs.fetchFromGitHub {
    owner = "nushell";
    repo = "nu_scripts";
    rev = "e380c8a355b4340c26dc51c6be7bed78f87b0c71";
    sha256 = "sha256-b2AeWiHRz1LbiGR1gOJHBV3H56QP7h8oSTzg+X4Shk8=";
  };
in
{
  options.shell.nushell = {
    enable = lib.mkEnableOption "Nushell terminal environment";
  };

  config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    # Core utilities
    bat
    eza
    fd
    fzf
    ripgrep

    # Shell enhancements
    atuin
    carapace
    starship
    zoxide

    # Other tools
    lazygit
    sesh
    tldr
    vivid
    yq
  ];

  # Set XDG directory override BEFORE nushell module runs
  xdg.enable = true;

  programs.nushell = {
    enable = true;
    extraEnv = ''
      $env.LOCAL_CONFIG_FILE = $"($nu.data-dir)/vendor/autoload/config.nu"
      $env.NU_CONFIG_DIR = ($env.HOME | path join '.config/nushell')
      $env.config.table.show_empty = false
      $env.config.hooks.pre_prompt = (
        $env.config.hooks.pre_prompt | append (source ${nu-scripts}/nu-hooks/nu-hooks/direnv/config.nu)
      )
      source ~/dotfiles/config/nushell/env.nu
    '';
    extraConfig = ''
      source ${nu-scripts}/themes/nu-themes/catppuccin-mocha.nu
      source ${nu-scripts}/custom-menus/zoxide-menu.nu
      source ~/dotfiles/config/nushell/config.nu
    '';
  };

  # Copy entire nushell config directory to ~/.config/nushell
  home.file.".config/nushell" = {
    recursive = true;
    source = ../../config/nushell;
  };

  # CRITICAL: Set these environment variables so nushell uses .config/nushell
  home.sessionVariables = {
    # NU_CONFIG_DIR = "${config.home.homeDirectory}/.config/nushell";
    # NU_LIB_DIRS = "${config.home.homeDirectory}/.config/nushell/scripts:${config.home.homeDirectory}/.config/nushell/completions";
    # NU_PLUGIN_DIRS = "${config.home.homeDirectory}/.config/nushell/plugins:/run/current-system/sw/bin";
    # XDG_CACHE_HOME  = "$HOME/.cache";
    # XDG_CONFIG_HOME = "$HOME/.config";
    # XDG_BIN_HOME    = "$HOME/.local/bin";
  };
 };
}
