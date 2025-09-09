{ config, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/Downloads/evening-sky.png" ];
      wallpaper = [ ", ~/Downloads/evening-sky.png" ];
    };
  };

  home.packages = with pkgs; [ hyprpaper ];
}
