{ ... }:
{
  imports = [
    # ./nushell.nix
    # ./zen
    # ./zen.nix

    ./lang
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
    ./editor/neovim.nix
    ./editor/zed.nix
    ./fastfetch.nix
    ./bat.nix
    ./ghostty.nix
    ./atuin.nix
    ./aerospace.nix
    ./mpv.nix
    ./spicetify.nix
  ];
}
