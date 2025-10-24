{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [ "custom/monitor" "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [ "pulseaudio" "clock" "custom/power" ];

        "custom/monitor" = {
          exec = "~/.config/waybar/scripts/monitor_id.sh";
          return-type = "json";
          interval = 60;
          tooltip = true;
          format = "   {}";
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

        "clock" = {
          timezone = "Europe/Zurich";
          tooltip = false;
          format-alt = "{:%H:%M}";
          format = "{:%H:%M - %d.%m.%Y}";
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
      @define-color primary    #ce53e0;
      @define-color secondary  #a6adc8;

      @define-color background rgba(100, 100, 100, 0.25);
      @define-color foreground rgba(255, 255, 255, 0.8);

      @define-color card       rgba(255, 255, 255, 0.1);
      @define-color border     rgba(166, 173, 200, 0.2);

      * { 
        font-family: "JetBrainsMono Nerd Font";
      }

      window#waybar {
        background: transparent;
        color: @foreground;
      }

      window#waybar>box {
        padding: 5px 8px 0px 8px;
      }

      #custom-monitor {
        background: @background;
        border: 2px solid @border;
        border-radius: 8px;
        margin-right: 5px;
        padding: 5px 13px;
      }

      #workspaces {
        background: @background;
        border: 2px solid @border;
        border-radius: 8px;
        padding: 5px 2px 5px 2px;
      }

      #workspaces button.active {
        color: @primary;
        transition: color 0.5s ease;
      }

      #workspaces button:hover {
        color: @foreground;
        background: rgba(255, 255, 255, 0.2);
      }

      #pulseaudio {
        background: @background;
        border: 2px solid @border;
        border-radius: 8px;
        padding: 5px 8px;
        margin-right: 5px;
      }

      #clock {
        background: @background;
        border: 2px solid @border;
        border-radius: 8px;
        padding: 5px 8px;
        margin-right: 5px;
      }

      #custom-power {
        background: @background;
        border: 2px solid @border;
        border-radius: 8px;
        padding: 5px 18px 5px 14px;
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
    pavucontrol
    wlogout
    jq 
  ];
}