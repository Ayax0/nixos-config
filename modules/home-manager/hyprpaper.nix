{ config, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/Downloads/Mountain.png" ];
      wallpaper = [ ", ~/Downloads/Mountain.png" ];
    };
  };

  home.packages = with pkgs; [ hyprpaper ];
}