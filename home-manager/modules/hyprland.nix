{
  pkgs,
  config,
  inputs,
  system,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.default;

    plugins = [
      inputs.split-monitor-workspaces.packages.${system}.split-monitor-workspaces
    ];

    settings = {
      monitor = [
        "HDMI-A-1,1920x1080@60,0x0,1"
        "HDMI-A-3,1920x1080@60,1920x0,1"
        "HDMI-A-4,1920x1080@60,3840x0,1"
        "DP-2,1680x1050@60,240x1080,1"
        "DP-3,1920x1080@60,1920x1080,1"
        "DP-4,1920x1080@60,3840x1080,1"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgb(ce53e0)";
        "col.inactive_border" = "rgb(a6adc8)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
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

      input.kb_layout = "ch";

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      cursor.no_hardware_cursors = true;

      plugin = {
        split-monitor-workspaces = {
          count = 3;
        };
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

        "bind = $mainMod, 1, split-workspace, 1"
        "bind = $mainMod, 2, split-workspace, 2"
        "bind = $mainMod, 3, split-workspace, 3"

        "bind = $mainMod SHIFT, 1, split-movetoworkspacesilent, 1"
        "bind = $mainMod SHIFT, 2, split-movetoworkspacesilent, 2"
        "bind = $mainMod SHIFT, 3, split-movetoworkspacesilent, 3"

        ", Print, exec, hyprshot -m window"
        "SHIFT, Print, exec, hyprshot -m region"
        "CTRL, Print, exec, hyprshot -m output"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "opacity 0.92 0.92, match:class ^(.*)$"
        "opacity 1.0 1.0, match:class ^(google-chrome)$"

        "float on, match:title ^(Picture-in-Picture)$"
        "size 400 225, match:title ^(Picture-in-Picture)$"
        "move (monitor_w-420) (monitor_h-245), match:title ^(Picture-in-Picture)$"
        "keep_aspect_ratio 1, match:title ^(Picture-in-Picture)$"
      ];

      layerrule = [
        "blur on, match:namespace logout_dialog"
      ];

      env = [
        "WEBKIT_DISABLE_DMABUF_RENDERER,1"

        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        "ELECTRON_FORCE_DARK_MODE,true"
        "ELECTRON_ENABLE_WAYLAND,1"

        "QT_QPA_PLATFORM,wayland;xcb"

        "HYPRSHOT_DIR,${config.home.homeDirectory}/Pictures/Screenshots"
      ];
    };
  };

  home.packages = with pkgs; [
    hyprshot
  ];
}
