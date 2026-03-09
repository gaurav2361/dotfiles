{ inputs, ... }:
{
  imports = [ inputs.vicinae.homeManagerModules.default ];

  services.vicinae = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl enable --now --user vicinae.service"
  ];
}
