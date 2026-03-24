{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "lang.python";
  description = "Python (uv) development environment";
  config = {
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
