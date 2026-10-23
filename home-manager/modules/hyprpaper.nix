{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${../../assets/background.png}" ];
      wallpaper = [ ", ${../../assets/background.png}" ];
    };
  };
}
