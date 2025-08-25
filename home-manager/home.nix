{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "ayax0";
    homeDirectory = "/home/ayax0";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Simon Gander";
    userEmail = "sg@vtt.ch";
    extraConfig.init.defaultBranch = "main";
  };

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
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Mauve-Dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
    XDG_CURRENT_DESKTOP = " Hyprland:dark";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
