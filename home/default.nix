{ ... }:
{
  imports = [
    # ./nushell.nix
    # ./zen
    # ./zen.nix

    ./lang
    ./editor
    ./tmux.nix
    ./zsh.nix
    ./direnv.nix
    ./starship.nix
    ./nh.nix
    ./btop.nix
    ./git
    ./lazydocker.nix
    ./fastfetch.nix
    ./bat.nix
    ./ghostty.nix
    ./atuin.nix
    ./aerospace.nix
    ./mpv.nix
    ./spicetify.nix
  ];

  editors = {
    neovim.enable = true;
  };

  # Disable manual generation to avoid options.json warning
  manual.manpages.enable = false;
  manual.json.enable = false;
  manual.html.enable = false;
}
