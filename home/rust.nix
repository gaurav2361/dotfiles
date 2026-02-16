{
  config,
  pkgs,
  lib,
  ...
}:

let
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
      build = {
        # Dynamically set jobs based on CPU threads
        jobs = config.lib.nixpkgs.parallelStock or 0;
      };
      install = {
        root = cargoHome;
      };
      net = {
        git-fetch-with-cli = true;
      };
    };

    # Ensure the bin directory exists for 'cargo install'
    activation.initRust = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ${cargoHome}/bin
    '';
  };
}
