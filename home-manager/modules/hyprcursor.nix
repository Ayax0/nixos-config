{ config, pkgs, lib, ... }:
{
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Mauve";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = with pkgs; [ hyprcursor catppuccin-cursors.mochaMauve ];
}