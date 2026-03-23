{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.lang.rust;
  cargoHome = "${config.home.homeDirectory}/.cargo";

  cargo-plugins = with pkgs; [
    cargo-sweep # Cleanup build artifacts
    cargo-edit # cargo add/rm/upgrade
    cargo-watch # hot reloading
    cargo-machete # find unused deps
    cargo-expand # macro expansion
    cargo-deny # dependency linter
    bacon # background checker
  ];
in
{
  options.lang.rust = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Rust development environment";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages =
        with pkgs;
        [
          # Core Toolchain
          rustc
          cargo
          clippy
          rustfmt
          rust-analyzer

          # System dependencies often needed for building crates
          pkg-config
          openssl
        ]
        # Add macOS-specific frameworks and libiconv securely
        ++ lib.optionals pkgs.stdenv.isDarwin [
          pkgs.libiconv
        ]
        ++ cargo-plugins;

      sessionVariables = {
        CARGO_HOME = cargoHome;
        RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
      };

      sessionPath = [ "${cargoHome}/bin" ];

      # Automatically generate the TOML with the Clang linker fix for Apple Silicon
      file.".cargo/config.toml".source = (pkgs.formats.toml { }).generate "cargo-config" {
        install = {
          root = cargoHome;
        };
        net = {
          git-fetch-with-cli = true;
        };
        # This safely injects the linker fix ONLY on macOS
        target = lib.optionalAttrs pkgs.stdenv.isDarwin {
          "aarch64-apple-darwin" = {
            linker = "clang";
          };
        };
      };

      activation.initRust = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p ${cargoHome}/bin
      '';
    };
  };
}
