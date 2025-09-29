{
  config,
  pkgs,
  lib,
  ...
}:
{
  ##### Hyprland managed by Home‑Manager #####
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    settings = {
      monitor = [
        "HDMI-A-1,1920x1080@60,0x0,1"
        "HDMI-A-3,1920x1080@60,1920x0,1"
        "HDMI-A-4,1920x1080@60,3840x0,1"
        "DP-2,1680x1050@60,240x1080,1"
        "DP-3,1920x1080@60,1920x1080,1"
        "DP-4,1920x1080@60,3840x1080,1"
      ];

      # workspace = [
      #   "1, monitor:DP-3, default:true, persistent:true"
      #   "2, monitor:DP-3"
      #   "3, monitor:HDMI-A-3, default:true, persistent:true"
      #   "4, monitor:HDMI-A-3"
      # ];

      #### ENVIRONMENT VARIABLES ####
      env = [
        "GTK_THEME,Adwaita:dark"
        "QT_QPA_PLATFORMTHEME,qt5ct"

        "ELECTRON_ENABLE_WAYLAND,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "NIXOS_OZONE_WL,1"
      ];

      #### LOOK & FEEL ####
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgb(cba6f7) rgb(f2cdcd) 90deg";
        "col.inactive_border" = "rgb(a6adc8)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 14;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      #### INPUT ####
      input = {
        kb_layout = "ch";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };

      cursor.no_hardware_cursors = true;
      gestures.workspace_swipe = false;

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      #### KEYBINDINGS ####
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, L, exec, hyprlock"

        # Move focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move active window with arrows
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # Switch workspaces
        # "$mainMod, 1, workspace, 1"
        # "$mainMod, 2, workspace, 2"
        # "$mainMod, 3, workspace, 3"
        # "$mainMod, 4, workspace, 4"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      #### WINDOWS & WORKSPACES ####
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
    };
  };
}
