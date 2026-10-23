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
  };

  # gtk-theme, icon-theme and font are written to dconf by the gtk module
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # libadwaita apps ignore gtk-theme; GTK_THEME forces Dracula on them too
  home.sessionVariables.GTK_THEME = "Dracula:dark";
}
