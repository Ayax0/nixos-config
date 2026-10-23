{ ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 13;
      wayland_titlebar_color = "system";
    };
  };
}
