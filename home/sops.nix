{
  config,
  pkgs,
  inputs,
  myLib,
  ...
}:
let
  module = myLib.mkHomeModule {
    name = "secrets.sops";
    description = "Enable SOPS for secrets management";
    globalConfig = config;
    enableDefault = true;
    config = {
      sops = {
        # Path to the age key file used to decrypt secrets
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

        # Default SOPS file for all secrets
        defaultSopsFile = ../secrets/secrets.yaml;

        # Basic setup for secrets
        secrets = { };
      };

      # Ensure sops and age are available in the home profile
      home.packages = with pkgs; [
        sops
        age
      ];
    };
  };
in
{
  inherit (module) options config;
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
}
