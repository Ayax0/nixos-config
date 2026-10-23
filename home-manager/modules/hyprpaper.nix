{ ... }:
{
  services.hyprpaper = {
    enable = true;
    # hyprpaper draws hyprland's splash quote onto the wallpaper unless told not to
    settings.splash = false;
    settings.wallpaper = {
      monitor = "*";
      path = "${../../assets/background.png}";
    };
  };
}
