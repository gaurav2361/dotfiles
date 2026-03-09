{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.cli.atuin;
in
{
  options.cli.atuin = {
    enable = lib.mkEnableOption "Atuin shell history sync";
  };
  config = lib.mkIf cfg.enable {
    # to address a slow startup sometimes
    # go to https://github.com/atuinsh/atuin/issues/952
    programs.atuin = {
      enable = true;
      package = pkgs.atuin;
      # https://github.com/atuinsh/atuin/issues/1199#issuecomment-1940931241
      # settings = {
      #   sync = {
      #     records = true;
      #   };
      #   # use this to disable auto sync
      #   auto_sync = true;
      #
      #   filter_mode_shell_up_key_binding = "session";
      #
      #   # use ctrl instead of alt as the shortcut modifier key for numerical UI shortcuts
      #   ctrl_n_shortcuts = true;
      #   keymap_mode = "vim-insert";
      # };
    };
    home.file.".config/atuin/config.toml" = {
      source = ../config/atuin/config.toml;
    };
  };
}
