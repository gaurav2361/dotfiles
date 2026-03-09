{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.cli.tmux;
in
{
  options.cli.tmux = {
    enable = lib.mkEnableOption "Tmux with custom dotfiles symlink";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      sesh
      tmuxinator
      yq
    ];
    programs.tmux = {
      enable = true;
      # tmuxp.enable = false;

      plugins = with pkgs.tmuxPlugins; [
        # pain-control
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
