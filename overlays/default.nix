{ inputs, ... }:
{
  # Overlay custom derivations into nixpkgs so you can use pkgs.<name>
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # https://wiki.nixos.org/wiki/Overlays
  modifications = final: prev: {
    nh = inputs.nh.packages.${final.stdenv.hostPlatform.system}.default;

    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };

    # Fix direnv hanging on aarch64-darwin during checkPhase
    # https://github.com/NixOS/nixpkgs/issues/507531
    direnv = prev.direnv.overrideAttrs (oldAttrs: {
      doCheck = if final.stdenv.isDarwin then false else (oldAttrs.doCheck or true);
    });

    # Fix Jeepney D-Bus test failures and import checks
    # pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    #   (python-final: python-prev: {
    #     jeepney = python-prev.jeepney.overridePythonAttrs (oldAttrs: {
    #       doInstallCheck = false;
    #       doCheck = false;
    #       pythonImportsCheck = [ "jeepney" ];
    #     });
    #   })
    # ];
  };
}
