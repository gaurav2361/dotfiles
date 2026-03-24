{ myLib, 
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "editors.neovim";
  description = "Nvim Editor with custom dotfiles symlink";
  config = {
    home.packages = with pkgs; [
      nixfmt
      statix
    ];

    programs.neovim = {
      enable = true;
      withPython3 = true;
      extraPython3Packages =
        ps: with ps; [
          pynvim
          pip
        ];

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
        selene
        biome
        uv
        gopls
        gofumpt
        stylua
        rustfmt
        harper
        gnumake
        go
        gcc
        cargo
        rustc
        rustup
        ripgrep
        wordnet
        imagemagick
        libiconv
      ];

      extraWrapperArgs = [
        "--suffix"
        "LIBRARY_PATH"
        ":"
        "${lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ]}"
      ];

      plugins = [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      ];
    };

    home.file.".config/nvim".source = builtins.toString (
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim"
    );
  };
}
