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
    includes = [
      { path = "${config.home.homeDirectory}/dotfiles/config/git/config"; }
    ];
  };
  home.file.".config/git/ignore".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/git/gitignore"
  );
  home.file.".config/git/template".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/git/template"
  );

}
