{ ... }:

{
  # uwsm runs hyprland as a systemd unit and drives graphical-session.target;
  # hyprland exports WAYLAND_DISPLAY and friends to systemd itself
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
