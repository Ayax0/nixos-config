{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = { name = "kvantum"; package = pkgs.catppuccin-kvantum; };
  };

  home.file.".config/Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha
  '';

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  home.packages = with pkgs; [ catppuccin-kvantum ];
}
