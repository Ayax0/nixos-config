{ ... }:

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
        path = "/etc/nixos/assets/background-blur.png";
      };

      input-field = {
        monitor = "DP-2";
        size = "300, 50";
        outline_thickness = 2;
        dots_center = true;
        check_color = "rgba(203, 166, 247, 0.8)";
        outer_color = "rgba(255, 255, 255, 0)";
        inner_color = "rgba(255, 255, 255, 0.1)";
        font_color = "rgb(200, 200, 200)";
      };

      label = [
        {
          monitor = "DP-2";
          text = "$TIME";
          font_size = 80;
          font_family = "JetBrains Mono Bold";
          position = "0, 100";
        }
      ];
    };
  };
}