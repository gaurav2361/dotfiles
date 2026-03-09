{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.lang.zig;
in
{
  options.lang.zig = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Zig development environment";
    };
  };

  config = lib.mkIf cfg.enable {
    # Since programs.zig doesn't exist, we put the packages in home.packages
    home.packages = with pkgs; [
      zig # The compiler
      zls # The Language Server (LSP)
    ];

    # If you want Zsh integration (like completions),
    # most of the time the zig package handles this,
    # but you can add custom shell logic here if needed.
  };
}
