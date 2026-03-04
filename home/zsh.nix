{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./eza.nix
  ];

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
    zinit
    zsh-autocomplete
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
}
