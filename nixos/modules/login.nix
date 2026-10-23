{ ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # the hyprland package also ships hyprland-uwsm.desktop, which sorts first and
    # fails without uwsm: always preselect the plain session instead of the last one
    settings.Users.RememberLastSession = false;
  };
  services.displayManager.defaultSession = "hyprland";

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.hyprlock.enableGnomeKeyring = true;

  security.soteria.enable = true;
}
