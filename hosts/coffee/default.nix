# hosts/coffee/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/darwin
    ../../modules/common
  ];

  ids.gids.nixbld = 350;
  networking.hostName = "coffee";
  system.primaryUser = "gaurav";

  nixpkgs.config.allowBroken = true;
  modules.darwin = {
    homebrew.enable = true;
    settings.enable = true;
    packages.enable = true;
    fonts.enable = true;
    determinateNix.enable = true;
  };

  environment.systemPackages = with pkgs; [
    darwin.cctools
    llvmPackages.bintools
    # nushell
  ];
  environment.shells = [
    # pkgs.nushell
    pkgs.zsh
  ];

  users.users.gaurav = {
    uid = 501;
    description = "Gaurav";
    home = "/Users/gaurav";
    shell = pkgs.zsh;
  };
}
