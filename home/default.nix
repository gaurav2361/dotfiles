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
    ./git.nix
    ./lazygit.nix
    ./gh.nix
    ./jujutsu.nix
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
}
