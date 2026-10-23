{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-purple-dark";
    };

    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    # gtk4 apps get the theme from GTK_THEME below
    gtk4.theme = null;
  };

  # gtk-theme, icon-theme and font are written to dconf by the gtk module
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # libadwaita ignores the gtk-theme setting; GTK_THEME applies Dracula to gtk3 and gtk4 apps
  home.sessionVariables.GTK_THEME = "Dracula:dark";
}
