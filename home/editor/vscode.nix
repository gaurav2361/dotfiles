{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.editors.vscode;
in
{
  options.editors.vscode = {
    enable = lib.mkEnableOption "Visual Studio Code";
  };

  config = lib.mkIf cfg.enable {
    # Allow the VS Code binary even though it's unfree
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      # You can add extensions = with pkgs.vscode-extensions; [ ... ] here later
    };
  };
}
