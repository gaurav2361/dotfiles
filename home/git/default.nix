{ myLib, 
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./gh.nix
    ./jujutsu.nix
    ./lazygit.nix
  ];
}
// myLib.mkHomeModule {
  globalConfig = config;
  name = "versionControl.git";
  description = "Git version control system";
  config = {
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
  };
}
