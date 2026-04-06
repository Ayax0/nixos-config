{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "custom/monitor"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
          "image/weather"
          "custom/weather"
        ];
        modules-right = [
          "pulseaudio"
          "memory"
          "tray"
          "custom/power"
        ];

        "custom/monitor" = {
          exec = "~/.config/waybar/scripts/monitor.sh";
          return-type = "json";
          interval = 60;
          format = "<span size='12000'>{text}</span>";
          tooltip = true;
        };

        "hyprland/workspaces" = {
          all-outputs = false;
          "on-click" = "activate";
          "format" = "{icon}";
          "format-icons" = {
            "active" = "";
            "default" = "";
          };
        };

        "clock" = {
          interval = 1;
          tooltip = false;
          timezone = "Europe/Zurich";
          format = "<span size='12000' foreground='#87acf0'><b>{0:%H:%M:%S}</b></span>\n<span size='8000' foreground='#a7abc9'><b>{0:%A, %B %d}</b></span>";
        };

        "custom/weather" = {
          interval = 600;
          exec = "curl -s 'https://wttr.in/Lucerne?format=%t'";
          format = "<span rise='5000' foreground='#f8b08a'><b>{}</b></span>";
        };

        "pulseaudio" = {
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

        "memory" = {
          interval = 10;
          format = " {}%";
          max-length = 10;
        };

        "tray" = {
          icon-size = 20;
          spacing = 10;
        };

        "custom/power" = {
          tooltip = false;
          on-click = "wlogout -b 4 &";
          format = "⏻";
        };
      }
    ];

    # CSS-Styling
    style = ''
      @define-color primary    #cba4f6;
      @define-color secondary  #4a495f;

      @define-color background #282840;
      @define-color foreground #a7abc9;

      @define-color border     #313248;

      * { 
        font-family: "JetBrainsMono Nerd Font";
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: @foreground;
      }

      window#waybar>box {
        padding: 5px 8px 0px 8px;
      }

      .modules-left {
        background: @background;
        border: 1px solid @border;
        border-radius: 32px;
        padding: 0;
      }

      #custom-monitor {
        background: linear-gradient(to right, #a6cfff, #d5a6f5);
        color: black;
        border-radius: 20px;
        margin: 5px;
        padding: 0 14px;
      }

      #workspaces {
        border: none;
        padding: 10px;
      }

      #workspaces button {
        background: @secondary;
        border-radius: 12px;
        padding: 2px 4px;
      }

      #workspaces button:not(:last-child) {
        margin-right: 10px;
      }

      #workspaces button.active {
        color: @primary;
        transition: color 0.5s ease;
      }

      .modules-center {
        background: @background;
        border: 1px solid @border;
        border-radius: 8px;
        padding: 4px 12px;
      }

      #clock {
        margin-right: 24px;
      }

      .modules-right {
        background: @background;
        border: 1px solid @border;
        border-radius: 32px;
        padding: 0;
      }

      #pulseaudio {
        color: black;
        background: linear-gradient(to right, #89b3f7, #7ac2ed);
        border-radius: 20px;
        margin: 5px;
        margin-right: 0;
        padding: 0 12px;
        border: none;
      }

      #memory {
        color: black;
        background: linear-gradient(to right, #cfa7f4, #efbce8);
        border-radius: 20px;
        margin: 5px;
        padding: 0 12px;
        border: none;
      }

      #tray {
        border: none;
        padding: 0 16px;
      }

      #custom-power {
        border: none;
        background: @secondary;
        color: @primary;
        margin: 5px;
        border-radius: 20px;
        padding: 0 15px 0 13px;
      }
    '';
  };

  home.file.".config/waybar/scripts/monitor.sh" = {
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

      # Waybar-kompatible JSON-Ausgabe
      jq -n -c \
        --arg text "$id" \
        --arg tooltip "$out (ID $id)" \
        '{text: $text, tooltip: $tooltip}'
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
    pavucontrol
    blueberry
    jq
  ];
}
