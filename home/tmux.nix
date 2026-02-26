{ pkgs, ... }:
{
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
}
