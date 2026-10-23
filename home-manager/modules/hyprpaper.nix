{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings.wallpaper = {
      monitor = "*";
      path = "${../../assets/background.png}";
    };
  };
}
