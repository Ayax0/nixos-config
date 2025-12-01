{ pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/etc/nixos/assets/background.png" ];
      wallpaper = [ ", /etc/nixos/assets/background.png" ];
    };
  };

  home.packages = with pkgs; [ hyprpaper ];
}
