# hosts/coffee/secrets/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  sops.secrets =
    let
      sshDir = "${config.home.homeDirectory}/.ssh";
    in
    {
      sshconfig = {
        path = "${sshDir}/config";
      };
      github-key = {
        path = "${sshDir}/github";
        mode = "0600";
      };
      signing-key = {
        path = "${sshDir}/key";
        mode = "0600";
      };
      signing-pub-key = {
        path = "${sshDir}/key.pub";
      };
      allowed-signers = {
        path = "${sshDir}/allowed_signers";
      };
      indiefluence-vps = {
        path = "${sshDir}/indiefluence_vps";
        mode = "0600";
      };
      indiefluence-vps-pub = {
        path = "${sshDir}/indiefluence_vps.pub";
      };
    };
}
