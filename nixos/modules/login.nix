{ config, ... }:

let
  # kwin draws the greeter cursor; running as the sddm user it needs a system-wide theme
  cursor = config.home-manager.users.ayax0.home.pointerCursor;
in
{
  services.displayManager.sddm = {
    enable = true;
    # weston drew no pointer here (the mouse only shows up ~20 s after the greeter);
    # kwin is sddm's reference compositor
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    settings.Theme = {
      CursorTheme = cursor.name;
      CursorSize = cursor.size;
    };
  };
  environment.systemPackages = [ cursor.package ];

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.hyprlock.enableGnomeKeyring = true;

  security.soteria.enable = true;
}
