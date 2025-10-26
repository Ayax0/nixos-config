{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "Catppuccin-Mocha-Mauve";
    size = 24;
  };
}