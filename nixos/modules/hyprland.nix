{ pkgs, ... }:

{
  # uwsm runs hyprland as a systemd unit and drives graphical-session.target;
  # hyprland exports WAYLAND_DISPLAY and friends to systemd itself
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # file pickers come from nautilus (through the gnome portal) and look like the file
  # manager; nautilus itself is installed by home-manager. The rest stays on hyprland/gtk
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
