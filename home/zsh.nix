{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.shell.zsh;
in
{
  options.shell.zsh = {
    enable = lib.mkEnableOption "Zsh shell environment";
  };
  imports = [
    ./eza.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      tldr
      sesh
      yq
      fd
      zoxide
      yazi
      fzf
      eza
      bat
      carapace
      vivid
      sheldon
    ];

    programs.zsh = {
      enable = true;
      initContent = ''source "$HOME/.config/zsh/.zshrc"'';
    };

    # home.file.".config/zsh".source = builtins.toString (
    #   config.lib.file.mkOutOfStoreSymlink ../config/zsh
    # );
    home.file.".config/zsh".source = builtins.toString (
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zsh"
    );

    home.file.".config/sheldon".source = builtins.toString (
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/sheldon"
    );
  };
}
