{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.editors.zed;
in
{
  options.editors.zed = {
    enable = lib.mkEnableOption "Zed Editor with custom dotfiles symlink";
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
    };

    # Links your ~/.config/zed to your local dotfiles folder
    home.file.".config/zed".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zed";
  };
}
