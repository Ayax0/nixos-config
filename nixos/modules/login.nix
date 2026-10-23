{ config, ... }:

let
  # the greeter runs as the sddm user and finds no cursor theme of its own
  cursor = config.home-manager.users.ayax0.home.pointerCursor;
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
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
