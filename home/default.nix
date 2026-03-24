{ ... }:
{
  imports = [
    # ./nushell.nix
    # ./zen
    # ./zen.nix

    ./lang
    ./editor
    ./tmux.nix
    ./git
    ./shell
    ./lazydocker.nix
    ./ghostty.nix
    ./aerospace.nix
    ./mpv.nix
    ./spicetify.nix
    ./sops.nix
  ];

  editors = {
    neovim.enable = true;
  };

  # Disable manual generation to avoid options.json warning
  manual.manpages.enable = false;
  manual.json.enable = false;
  manual.html.enable = false;
}
