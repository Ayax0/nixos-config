{ config, inputs, system, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = [
        "HDMI-A-1,1920x1080@60,0x0,1"
        "HDMI-A-3,1920x1080@60,1920x0,1"
        "HDMI-A-4,1920x1080@60,3840x0,1"
        "DP-2,1680x1050@60,240x1080,1"
        "DP-3,1920x1080@60,1920x1080,1"
        "DP-4,1920x1080@60,3840x1080,1"
      ];

      exec-once = [
        "swww img ~/nixos-config/assets/wallpapers/volkswagen-bus-anime-girl-sky-wallpaperwaifu-com.mp4 --transition-type none --loop"
      ];

      input.kb_layout = "ch";

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
        "col.active_border" = "rgb(cba6f7) rgb(f2cdcd) 90deg";
        "col.inactive_border" = "rgb(a6adc8)";
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes";

        bezier = [
          "smooth,0.25,0.1,0.25,1.0"
          "gentle,0.16,1.0,0.3,1.0"
        ];

        animation = [
          "global, 1, 6, smooth"
          "windows, 1, 4.5, gentle"
          "windowsIn, 1, 4.3, gentle, popin 80%"
          "windowsOut, 1, 3.5, smooth, popin 80%"
          "fade, 1, 2.8, smooth"
          "fadeIn, 1, 2.4, smooth"
          "fadeOut, 1, 2.4, smooth"
          "layers, 1, 3.5, smooth, fade"
          "workspaces, 1, 3.3, smooth, fade"
        ];
      };

      # KEYBINDINGS
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, L, exec, hyprlock"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        "$mainMod CTRL, left, movewindow, mon:l"
        "$mainMod CTRL, right, movewindow, mon:r"
        "$mainMod CTRL, up, movewindow, mon:u"
        "$mainMod CTRL, down, movewindow, mon:d"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "opacity 0.93 0.93,class:^(.*)$"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
      ];

      env = [
        "NIXOS_OZONE_WL,1"
        
        "GBM_BACKEND,nvidia-drm"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"

        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        "ELECTRON_FORCE_DARK_MODE,true"

        "WLR_DRM_NO_ATOMIC,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_DEVICES,/dev/dri/by-path/pci-0000:65:00.0-card"
        "AQ_DRM_DEVICES,/dev/dri/nvidia-main:/dev/dri/nvidia-secondary"
      ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" "hyprland" ];
      };
    };
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "Adwaita-Dark";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Adwaita";
    };
  };

  home.packages = with pkgs; [ dconf ];
}
