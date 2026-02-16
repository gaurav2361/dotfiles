{
  config,
  pkgs,
  ...
}:
{
  programs.zig = {
    enable = true;
    package = pkgs.zig;
    enableZshIntegration = config.programs.zsh.enable;
    lsp = true;
  };
}
