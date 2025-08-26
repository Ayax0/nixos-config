{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = {
        monitor = "";
        # path = "/path/zu/deinem/wallpaper.jpg";
        blur_passes = 2;
        blur_size = 8;
      };

      input-field = {
        size = "300, 50";
        outline_thickness = 2;
        dots_center = true;
      };

      label = [
        { text = "$TIME"; font_size = 36; position = "0, -150"; }
        { text = "Gesperrt – tippe dein Passwort"; position = "0, 140"; }
      ];
    };
  };

  home.packages = with pkgs; [ hyprlock ];
}