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
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    egl-wayland
  ];

  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };
}