{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    delta
    git-cliff
    gitoxide
    git-open
  ];
  programs.git = {
    enable = true;
  };

  # home.file.".config/git" = {
  #   recursive = true;
  #   source = ../config/git;
  # };

  home.file.".config/git".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/git"
  );

}
