# Those are my secrets, encrypted with sops
# You shouldn't import this file, unless you edit it
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
    };

  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];

  wayland.windowManager.hyprland.settings.exec-once = [ "systemctl --user start sops-nix" ];
}
