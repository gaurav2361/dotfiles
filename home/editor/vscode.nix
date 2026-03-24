{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "editors.vscode";
  description = "Visual Studio Code";
  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    };
  };
}
