{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "/Users/gaurav/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;

    secrets = {
      sshconfig = {
        path = "/Users/gaurav/.ssh/config";
      };
      github-key = {
        path = "/Users/gaurav/.ssh/github";
      };
      signing-key = {
        path = "/Users/gaurav/.ssh/key";
      };
      signing-pub-key = {
        path = "/Users/gaurav/.ssh/key.pub";
      };
      allowed-signers = {
        path = "/Users/gaurav/.ssh/allowed_signers";
      };
      indiefluence-vps = {
        path = "/Users/gaurav/.ssh/indiefluence_vps";
      };
      indiefluence-vps-pub = {
        path = "/Users/gaurav/.ssh/indiefluence_vps.pub";
      };
    };
  };

  home.packages = with pkgs; [
    sops
    age
  ];
}
