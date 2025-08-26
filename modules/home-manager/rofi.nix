{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "JetBrainsMono Nerd Font 14";

    extraConfig = {
      modi = "run,window,combi";
      terminal = "alacritty";
      show-icons = true;
      icon-theme = "Oranchelo";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-combi = " 🖥️  All ";
      display-run = " 🏃  Run ";
      display-window = " 🪟  Window";
      sidebar-mode = true;
    };

    theme = "mocha";
  };

  home.packages = with pkgs; [ rofi ];
}
