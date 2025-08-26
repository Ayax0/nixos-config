{ pkgs, ... }:
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
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    kvantum
    catppuccin-kvantum
  ];

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Mauve-Dark";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
