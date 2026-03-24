{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkHomeModule {
  globalConfig = config;
  name = "cli.tmux";
  description = "Tmux with custom dotfiles symlink";
  config = {
    home.packages = with pkgs; [
      sesh
      tmuxinator
      yq
    ];
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sessionist
      ];
      extraConfig = builtins.readFile ../config/tmux/tmux.conf;
    };
    home.file.".config/tmux" = {
      recursive = true;
      source = ../config/tmux;
    };
  };
}
