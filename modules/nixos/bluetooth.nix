# Bluetooth configuration for NixOS
{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.nixos.bluetooth;
in
{
  options.modules.nixos.bluetooth = {
    enable = mkEnableOption "NixOS Bluetooth system";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ blueman ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
