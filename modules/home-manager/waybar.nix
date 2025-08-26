{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 28;
      modules-left  = [ "sway/workspaces" "sway/mode" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "battery" "network" "tray" ];

      "clock" = { format = "{:%a %d.%m. %H:%M}"; tooltip = false; };
      "battery" = {
        format = "{capacity}% ";
        format-alt = "{time} remaining";
        states = { warning = 25; critical = 10; };
      };
      "network" = {
        format-wifi = "  {essid} {signalStrength}%";
        format-ethernet = " {ifname}";
        format-disconnected = "";
      };
      "pulseaudio" = {
        format = "{volume}% {icon}";
        format-muted = "muted ";
        "format-icons" = { default = [ "" "" ]; };
        on-click = "pamixer -t";
        on-scroll-up = "pamixer -i 2";
        on-scroll-down = "pamixer -d 2";
      };
      "tray" = { spacing = 8; };
    }];

    # CSS-Styling
    style = ''
      * { font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free"; font-size: 12px; }
      window#waybar { background: rgba(30,30,34,0.85); color: #e6e6e6; }
      #clock, #battery, #network, #pulseaudio, #tray { padding: 0 10px; }
      #battery.warning { color: #ffcc00; }
      #battery.critical { color: #ff5555; }
      tooltip { background: #1f2430; border: 1px solid #3b4252; }
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
      Environment = "XDG_CURRENT_DESKTOP=sway";
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };

  home.packages = with pkgs; [ waybar ];
}