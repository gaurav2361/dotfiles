{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.lang.rust;
  cargoHome = "${config.home.homeDirectory}/.cargo";

  # Group your plugins for better readability
  cargo-plugins = with pkgs; [
    cargo-sweep # Cleanup build artifacts
    cargo-edit # cargo add/rm/upgrade
    cargo-watch # hot reloading
    cargo-machete # find unused deps
    cargo-expand # macro expansion
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
          rust-analyzer
          rustfmt
          clippy

          # System dependencies often needed for building crates
          pkg-config
          openssl
        ]
        ++ cargo-plugins;

      sessionVariables = {
        CARGO_HOME = cargoHome;
        # Ensures rust-analyzer can find the source code of the standard library
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      };

      sessionPath = [ "${cargoHome}/bin" ];

      # Better than manual strings: use the TOML generator
      file.".cargo/config.toml".source = (pkgs.formats.toml { }).generate "cargo-config" {
        install = {
          root = cargoHome;
        };
        net = {
          git-fetch-with-cli = true;
        };
      };

      # Ensure the bin directory exists for 'cargo install'
      activation.initRust = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p ${cargoHome}/bin
      '';
    };
  };
}
