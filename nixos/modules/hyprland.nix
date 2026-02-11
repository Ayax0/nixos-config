{
  pkgs,
  inputs,
  system,
  lib,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    
    package = inputs.hyprland.packages.${system}.default;
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_DATA_DIRS = lib.mkBefore [
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };

  environment.systemPackages = with pkgs; [
    egl-wayland
  ];
}
