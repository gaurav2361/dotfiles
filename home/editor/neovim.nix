{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs)
    tree-sitter
    lua54Packages
    luajitPackages
    nodePackages_latest
    vimPlugins
    ;
  inherit (pkgs.tree-sitter-grammars)
    tree-sitter-lua
    tree-sitter-nix
    tree-sitter-go
    tree-sitter-python
    tree-sitter-bash
    tree-sitter-regex
    tree-sitter-markdown
    tree-sitter-json
    ;

  python313Env = pkgs.python313.withPackages (
    ps: with ps; [
      pynvim
      pip
    ]
  );
in
{
  home.packages = with pkgs; [
    nixfmt
    statix
  ];

  programs.neovim = {
    enable = true;
    withPython3 = false;
    extraPackages = with pkgs; [
      tree-sitter
      lua54Packages.jsregexp

      nodejs_22
      nodePackages_latest.vscode-json-languageserver
      vscode-langservers-extracted
      tailwindcss-language-server
      fzf
      unzip
      lua
      lua-language-server
      lua53Packages.luacheck
      luajitPackages.jsregexp
      lua51Packages.luarocks-nix
      luarocks
      nixd
      nixfmt
      statix
      selene
      gnumake
      go
      gcc
      # phpPackages.composer
      biome
      python313Env
      uv
      gopls
      gofumpt
      stylua
      cargo
      wordnet
      rustc
      rustup
      rustfmt
      ripgrep
      imagemagick
      libiconv
      harper
    ];

    extraWrapperArgs = [
      "--suffix"
      "LIBRARY_PATH"
      ":"
      "${lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ]}"
    ];

    plugins = [
      vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  home.file.".config/nvim".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim"
  );
}
