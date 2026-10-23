{
  config,
  lib,
  pkgs,
  ...
}:

let
  c = import ../../catppuccin.nix;
  inherit (config.home-manager.users.ayax0) gtk home;
  hyprland = config.programs.hyprland.package;
  xkb = config.services.xserver.xkb;

  # the greeter gets its own hyprland instance, on the main screen only
  greeterConfig = pkgs.writeText "greetd-hyprland.conf" ''
    monitor = DP-1, preferred, auto, 1
    monitor = , disable

    env = XCURSOR_THEME,${home.pointerCursor.name}
    env = XCURSOR_SIZE,${toString home.pointerCursor.size}

    input {
      kb_layout = ${xkb.layout}
      kb_variant = ${xkb.variant}
    }

    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      disable_hyprland_guiutils_check = true
    }

    ecosystem {
      no_update_news = true
      no_donation_nag = true
    }

    exec-once = ${lib.getExe config.programs.regreet.package}; ${hyprland}/bin/hyprctl dispatch exit
  '';
in
{
  # same look as the desktop
  programs.regreet = {
    enable = true;
    theme = { inherit (gtk.theme) package name; };
    iconTheme = { inherit (gtk.iconTheme) package name; };
    font = { inherit (gtk.font) package name size; };
    cursorTheme = { inherit (home.pointerCursor) package name; };

    # same backdrop as hyprlock, translucent panels like waybar and swaync
    settings.background = {
      path = "${../../assets/background-blur.png}";
      fit = "Cover";
    };
    extraCss = ''
      frame.background {
        background-color: alpha(${c.base}, 0.85);
        border: 1px solid alpha(${c.surface1}, 0.8);
        border-radius: 16px;
      }
    '';
  };
  services.greetd.settings.default_session.command =
    "${pkgs.dbus}/bin/dbus-run-session ${hyprland}/bin/start-hyprland -- -c ${greeterConfig}";

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.hyprlock.enableGnomeKeyring = true;
}
