{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules
    ../../home/docker.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  networking.hostName = "atlas"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  environment.systemPackages = [ pkgs.google-chrome ];
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.gaurav = {
      isNormalUser = true;
      description = "Gaurav";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = with pkgs; [
        #  thunderbird
      ];
    };
  };

  programs.zsh.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "gaurav";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; # Did you read the comment?

  modules = {
    common.packages.enable = true;
    nixos = {
      fonts.enable = true;
      nixld.enable = true;
      nix.enable = true;
      locale.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
      nvidia.enable = true;
      desktop.hyprland.enable = true;
    };
  };
}
