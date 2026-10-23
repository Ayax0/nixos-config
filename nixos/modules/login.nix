{ ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.hyprlock.enableGnomeKeyring = true;

  security.soteria.enable = true;
}
