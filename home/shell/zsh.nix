{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "shell.zsh";
  description = "Zsh shell environment";
  config = {
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

    home.file.".config/zsh".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zsh";

    home.file.".config/sheldon".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/sheldon";
  };
}
