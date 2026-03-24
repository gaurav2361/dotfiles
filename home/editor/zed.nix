{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "editors.zed";
  description = "Zed Editor with custom dotfiles symlink";
  config = {
    programs.zed-editor = {
      enable = true;
    };

    home.file.".config/zed".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zed";
  };
}
