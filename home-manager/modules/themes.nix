{ lib, pkgs, ... }:

let
  c = import ../../catppuccin.nix;
  # magnetic-catppuccin-gtk is mocha unless a flavor tweak is given
  gtkTheme = "Catppuccin-GTK-${lib.toSentenceCase c.accent}-Dark";
in
{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.magnetic-catppuccin-gtk.override { accent = [ c.accent ]; };
      name = gtkTheme;
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override { inherit (c) flavor accent; };
      name = "Papirus-Dark";
    };

    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    # gtk4 apps get the theme from GTK_THEME below
    gtk4.theme = null;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
  home.packages = [
    (pkgs.catppuccin-kvantum.override {
      variant = c.flavor;
      inherit (c) accent;
    })
  ];
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin-${c.flavor}-${c.accent}
  '';

  # gtk-theme, icon-theme and font are written to dconf by the gtk module
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # libadwaita ignores the gtk-theme setting; GTK_THEME applies it to gtk3 and gtk4 apps
  home.sessionVariables.GTK_THEME = gtkTheme;
}
