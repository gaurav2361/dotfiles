{
  pkgs,
  lib,
  ...
}:
lib.mkModule {
  name = "nixos.bluetooth";
  description = "NixOS Bluetooth system";
  config = {
    environment.systemPackages = with pkgs; [ blueman ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
