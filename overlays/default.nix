{ inputs, ... }:
{
  # Overlay custom derivations into nixpkgs so you can use pkgs.<name>
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # https://wiki.nixos.org/wiki/Overlays
  modifications = final: prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
