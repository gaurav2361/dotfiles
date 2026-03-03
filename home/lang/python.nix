{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.lang.python;
in
{
  options.lang.python = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Python (uv) development environment";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      python313 # Latest stable Python
      uv # Fast Python package manager
      ruff # Fast linter and formatter
      pyright # Static type checker (LSP)
    ];

    home.sessionVariables = {
      # Tell uv to use the Nix-provided Python by default
      UV_PYTHON = "${pkgs.python313}/bin/python";
      # Faster uv operations
      UV_LINK_MODE = "copy";
    };
  };
}
