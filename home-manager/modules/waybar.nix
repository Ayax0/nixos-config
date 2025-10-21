{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "network"
          "custom/monitor"
        ];
        modules-center = [ "custom/music" ];
        modules-right = [
          "pulseaudio"
          "clock"
          "tray"
          "custom/lock"
          "custom/power"
        ];

        "network" = {
          interface = "enp0s31f6";
          format = " {ipaddr}";
          format-disconnected = " Disconnected";
          tooltip = false;
        };

        "custom/monitor" = {
          exec = "~/.config/waybar/scripts/monitor_id.sh";
          return-type = "json";
          interval = 60;
          tooltip = true;
          format = " {}";
        };

        "tray" = {
          icon-size = 20;
          spacing = 10;
        };

        "custom/music" = {
          format = "  {}";
          escape = true;
          interval = 5;
          tooltip = false;
          exec = "playerctl metadata --format='{{ title }}'";
          on-click = "playerctl play-pause";
          max-length = 50;
        };

        "clock" = {
          timezone = "Europe/Zurich"; # Angepasst für die Schweiz
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = " {:%d/%m/%Y}";
          format = " {:%H:%M}";
        };

        "pulseaudio" = {
          # scroll-step = 1; # %, can be a float
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
              " "
            ];
          };
          on-click = "pavucontrol";
        };

        "custom/lock" = {
          tooltip = false;
          on-click = "sh -c '(sleep 0.5s; hyprlock)' & disown"; # Angepasst für Hyprland
          format = "󰌾";
        };

        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "⏻";
        };
      }
    ];

    # CSS-Styling
    style = ''
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;

      * { 
        font-family: "JetBrainsMono Nerd Font"; 
        font-size: 16px;
      }

      #waybar {
        background: transparent;
        color: @text;
        border: none;
      }

      #network,
      #custom-monitor,
      #custom-music,
      #tray,
      #backlight,
      #clock,
      #battery,
      #pulseaudio,
      #custom-lock,
      #custom-power {
        background-color: @surface0;
        padding: 5px 1rem;
        margin-top: 5px;
      }

      #network {
        color: @blue;
        border-radius: 8px 0px 0px 8px;
        margin-left: 0.5rem;
      }

      #custom-monitor {
        color: @blue;
        border-radius: 0px 8px 8px 0px;
        margin-right: 0.5rem;
      }

      #clock {
        color: @blue;
        border-radius: 0px 8px 8px 0px;
        margin-right: 0.5rem;
        padding-left: 0.5rem;
      }

      #pulseaudio {
        color: @maroon;
        border-radius: 8px 0px 0px 8px;
        padding-right: 0.5rem;
      }

      #custom-music {
        color: @mauve;
        border-radius: 1rem;
      }

      #custom-lock {
          border-radius: 8px 0px 0px 8px;
          color: @lavender;
      }

      #custom-power {
          border-radius: 0px 8px 8px 0px;
          color: @red;
          margin-right: 0.5rem;
      }

      #tray {
        margin-right: 0.5rem;
        border-radius: 8px;
      }
    '';
  };

  home.file.".config/waybar/scripts/monitor_id.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      # Waybar setzt das pro-Output:
      out="${"\${WAYBAR_OUTPUT_NAME:-}"}"

      # Fallback: nimm den ersten Monitor, falls Var fehlt (sollte selten passieren)
      if [[ -z "$out" ]]; then
        out="$(hyprctl monitors -j | jq -r '.[0].name')"
      fi

      # ID zum Namen finden
      id="$(hyprctl monitors -j | jq --arg out "$out" -r '.[] | select(.name==$out) | .id')"
      if [[ -z "$id" || "$id" == "null" ]]; then
        id=0
      fi

      # 1-basiert anzeigen
      num=$((id + 1))

      printf '{"text":"%d","tooltip":"Monitor %s (ID %s)"}\n' "$num" "$out" "$id"
    '';
  };

  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
      RestartSec = 3;
      Environment = "XDG_CURRENT_DESKTOP=Hyprland";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.packages = with pkgs; [
    waybar
    playerctl
    pavucontrol
    wlogout
    jq
  ];
}