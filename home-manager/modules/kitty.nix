{ lib, ... }:

let
  c = import ../../catppuccin.nix;
in
{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-${lib.toSentenceCase c.flavor}";

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 13;
      wayland_titlebar_color = "system";
    };
  };
}
