{ pkgs, osConfig, ... }:

let
  c = import ../../catppuccin.nix;

  # shows the hyprland monitor id of the bar's output
  monitorId = pkgs.writeShellApplication {
    name = "waybar-monitor-id";
    runtimeInputs = [
      pkgs.jq
      osConfig.programs.hyprland.package
    ];
    text = ''
      out="''${WAYBAR_OUTPUT_NAME:-$(hyprctl monitors -j | jq -r '.[0].name')}"
      id="$(hyprctl monitors -j | jq -r --arg out "$out" '.[] | select(.name == $out) | .id')"
      jq -n -c --arg id "''${id:-0}" --arg out "$out" '{text: $id, tooltip: "\($out) (ID \($id))"}'
    '';
  };
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

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
          "custom/weather"
        ];
        modules-right = [
          "pulseaudio"
          "memory"
          "tray"
          "custom/power"
        ];

        "custom/monitor" = {
          exec = "${monitorId}/bin/waybar-monitor-id";
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
          format = "<span size='12000' foreground='${c.blue}'><b>{0:%H:%M:%S}</b></span>\n<span size='8000' foreground='${c.subtext0}'><b>{0:%A, %B %d}</b></span>";
        };

        "custom/weather" = {
          interval = 600;
          exec = "curl -s 'https://wttr.in/Lucerne?format=%t'";
          format = "<span rise='5000' foreground='${c.peach}'><b>{}</b></span>";
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
      @define-color primary    ${c.mauve};
      @define-color secondary  ${c.surface1};

      @define-color background ${c.base};
      @define-color foreground ${c.subtext1};

      @define-color border     ${c.surface0};
      @define-color dark       ${c.crust};

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
        background: linear-gradient(to right, ${c.blue}, ${c.mauve});
        color: @dark;
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
        color: @dark;
        background: linear-gradient(to right, ${c.blue}, ${c.sapphire});
        border-radius: 20px;
        margin: 5px;
        margin-right: 0;
        padding: 0 12px;
        border: none;
      }

      #memory {
        color: @dark;
        background: linear-gradient(to right, ${c.mauve}, ${c.pink});
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

  home.packages = with pkgs; [
    pavucontrol
  ];
}
