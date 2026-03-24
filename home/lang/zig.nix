{
  myLib,
  config,
  lib,
  pkgs,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "lang.zig";
  description = "Enable Zig development environment";
  config = {
    home.packages = with pkgs; [
      zig # The compiler
      zls # The Language Server (LSP)
    ];

    # If you want Zsh integration (like completions),
    # most of the time the zig package handles this,
    # but you can add custom shell logic here if needed.
  };
}
