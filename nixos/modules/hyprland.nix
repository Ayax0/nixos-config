{ pkgs, inputs, system, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${system}.default;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common = {
        default = [ "hyprland" "gtk" "wlr" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    egl-wayland
  ];

  environment.variables = {
    NIXOS_OZONE_WL = "1";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}