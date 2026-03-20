{
  lib,
  isNixOS ? false,
  isDarwin ? false,
  ...
}:
{
  imports = [
    ./common
  ]
  ++ lib.optional isDarwin ./darwin
  ++ lib.optional isNixOS ./nixos;
}
