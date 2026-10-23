{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/etc/nixos/assets/background.png" ];
      wallpaper = [ ", /etc/nixos/assets/background.png" ];
    };
  };
}
