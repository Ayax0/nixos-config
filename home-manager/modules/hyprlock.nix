{ lib, ... }:

let
  c = import ../../catppuccin.nix;
  hex = lib.removePrefix "#";
in
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
        path = "${../../assets/background-blur.png}";
      };

      input-field = {
        monitor = "DP-1";
        size = "300, 50";
        outline_thickness = 2;
        dots_center = true;
        outer_color = "rgba(${hex c.surface1}aa)";
        inner_color = "rgba(${hex c.base}cc)";
        font_color = "rgb(${hex c.text})";
        check_color = "rgb(${hex c.mauve})";
        fail_color = "rgb(${hex c.red})";
      };

      label = [
        {
          monitor = "DP-1";
          text = "<b>$TIME</b>";
          font_size = 80;
          font_family = "JetBrainsMono Nerd Font";
          color = "rgb(${hex c.text})";
          position = "0, 100";
        }
      ];
    };
  };
}
