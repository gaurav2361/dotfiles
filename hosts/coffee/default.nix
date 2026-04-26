# hosts/coffee/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules
  ];

  ids.gids.nixbld = 350;
  networking.hostName = "coffee";
  system.primaryUser = "gaurav";

  modules = {
    common.packages.enable = true;
    darwin = {
      homebrew.enable = false;
      nanobrew = {
        enable = true;
        autoMigrate = true;
        user = "gaurav";
        casks = [
          "iina"
          "blip"
          "bruno"
          "motrix"
          "raycast"
          "spotify"
          "obsidian"
          "antigravity"
          "google-drive"
          "google-chrome"
          "brave-browser"
          "keyboardcleantool"
          "mhaeuser/mhaeuser/battery-toolkit"
        ];
        brews = [
          "mas"
          "mole"
          "sheets"
          "libiconv"
          "tesseract"
          "gemini-cli"
          "tree-sitter"
          "tesseract-lang"
          "tree-sitter-cli"
          "netbirdio/tap/netbird"
          "Arthur-Ficial/tap/apfel"
        ];
      };
      settings.enable = true;
      packages.enable = true;
      fonts.enable = true;
      determinateNix.enable = true;
    };
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
