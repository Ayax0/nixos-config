{ ... }:

{
  # the hyprland package also ships "Hyprland (uwsm-managed)", listed first, which fails
  # without uwsm; sddm ignores DefaultSession, so pick "Hyprland" once, it is remembered
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.hyprlock.enableGnomeKeyring = true;

  security.soteria.enable = true;
}
