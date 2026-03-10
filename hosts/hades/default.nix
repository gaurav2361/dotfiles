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
    ./disko-config.nix
    ../../home/docker.nix
    ../../modules
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  networking.hostName = "hades"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = false; # Disable NetworkManager for static IP

  # Static IP configuration
  networking = {
    useDHCP = false;
    interfaces.eno1 = {
      # Change 'eno1' to your actual interface name
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.24.30"; # Change to your desired static IP
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "192.168.1.254"; # Change to your router's IP
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ]; # Or use your preferred DNS servers
  };

  # Enable OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true; # Set to false after setting up SSH keys
      X11Forwarding = false;
    };
    openFirewall = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    neovim
    vim
    wget
  ];

  # Define a user account. Don't forget to set a password with 'passwd'.
  users = {
    defaultUserShell = pkgs.zsh;
    users.gaurav = {
      isNormalUser = true;
      description = "gaurav server";
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

  # Disable automatic login for security (recommended for servers)
  services.displayManager.autoLogin.enable = false;
  # services.displayManager.autoLogin.user = "gaurav";

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

  modules = {
    common.packages.enable = true;
    nixos = {
      nix.enable = true;
    };
  };
}
