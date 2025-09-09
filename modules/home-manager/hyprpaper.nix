{ config, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/nixos-config/assets/evening-sky.png" ];
      wallpaper = [ ", ~/nixos-config/assets/evening-sky.png" ];
    };
  };

  home.packages = with pkgs; [ hyprpaper ];
}
