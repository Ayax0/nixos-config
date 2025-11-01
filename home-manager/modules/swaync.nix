{ pkgs, ... }:

{
  home.packages = with pkgs; [ swaynotificationcenter ];

  xdg.configFile."swaync/config.json".text = ''
    {
      "position": "top-right",
      "monitor": "focused",
      "control-center": {
        "enabled": true,
        "width": 400,
        "height": 600
      }
    }
  '';

  xdg.configFile."swaync/style.css".text = ''
    * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 12pt;
      color: rgba(255, 255, 255, 0.8);
    }

    .notification {
      background-color: rgba(100, 100, 100, 0.25);
      border: 2px solid rgba(166, 173, 200, 0.2);

      border-radius: 8px;
    }

    .notification-content {
      background-color: transparent;
      padding: 5px;
    }

    .notification-content:hover {
      background-color: #ff0000;
    }
  '';
}
