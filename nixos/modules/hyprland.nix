{
  config,
  lib,
  pkgs,
  ...
}:

let
  # the hyprland package also ships "Hyprland (uwsm-managed)", which sddm lists first
  # and preselects; it fails because uwsm is not set up, so register only the plain session
  plainSession = pkgs.runCommand "hyprland-session" { passthru.providedSessions = [ "hyprland" ]; } ''
    install -Dm444 -t $out/share/wayland-sessions \
      ${config.programs.hyprland.package}/share/wayland-sessions/hyprland.desktop
  '';
in
{
  programs.hyprland.enable = true;
  services.displayManager.sessionPackages = lib.mkForce [ plainSession ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
