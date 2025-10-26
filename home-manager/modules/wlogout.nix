{ pkgs, ... }:

{
  home.file.".config/wlogout/layout".text = ''
    { "label": "lock", "action": "hyprlock" }
    { "label": "logout", "action": "loginctl terminate-user $USER" }
    { "label": "reboot", "action": "systemctl reboot" }
    { "label": "shutdown",  "action": "systemctl poweroff" }
  '';

  home.file.".config/wlogout/style.css".text = ''
    @define-color primary    #ce53e0;

    window {
      background-color: transparent;
    }

    button {
      margin: 10px 4px 10px 4px;
      background-color: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      background-repeat: no-repeat;
      background-position: center;
      background-size: 40%;
    }

    button:hover {
      margin: 0px;
      background-color: rgba(205, 83, 224, 0.1);
      background-size: 45%;
    }

    #lock {
      background-image: image(url("/etc/nixos/assets/icons/LucideLock.svg"));
    }

    #logout {
      background-image: image(url("/etc/nixos/assets/icons/LucideLogOut.svg"));
    }

    #reboot {
      background-image: image(url("/etc/nixos/assets/icons/LucideRefreshCcw.svg"));
    }

    #shutdown {
      background-image: image(url("/etc/nixos/assets/icons/LucidePower.svg"));
    }
  '';

  home.packages = with pkgs; [ wlogout ];
}