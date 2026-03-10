{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.editors.neovim;
in
{
  options.editors.neovim = {
    enable = lib.mkEnableOption "Nvim Editor with custom dotfiles symlink";
  };

  config = lib.mkIf cfg.enable {
    # Optional: Keep here if you want these available in your general terminal CLI
    home.packages = with pkgs; [
      nixfmt
      statix
    ];

    programs.neovim = {
      enable = true;

      # Cleaner, native Nix way to provide Python to Neovim
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

        # LSPs and Formatters
        nixd
        selene
        biome
        uv
        gopls
        gofumpt
        stylua
        rustfmt
        harper

        # Compilers and Core Tools
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
        # This already pulls in all grammars, making individual grammar declarations unnecessary
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      ];
    };

    # Links to your live dotfiles repo for instant Lua editing
    home.file.".config/nvim".source = builtins.toString (
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim"
    );
  };
}
