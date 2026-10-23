{ ... }:

let
  c = import ../../catppuccin.nix;
in
{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "hyprlock";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
      }
    ];

    style = ''
      window {
        background-color: transparent;
      }

      button {
        margin: 10px 4px 10px 4px;
        background-color: alpha(${c.base}, 0.6);
        border: 1px solid alpha(${c.surface1}, 0.8);
        background-repeat: no-repeat;
        background-position: center;
        background-size: 40%;
      }

      button:hover {
        margin: 0px;
        background-color: alpha(${c.mauve}, 0.15);
        border-color: ${c.mauve};
        background-size: 45%;
      }

      #lock {
        background-image: image(url("${../../assets/icons}/LucideLock.svg"));
      }

      #logout {
        background-image: image(url("${../../assets/icons}/LucideLogOut.svg"));
      }

      #reboot {
        background-image: image(url("${../../assets/icons}/LucideRefreshCcw.svg"));
      }

      #shutdown {
        background-image: image(url("${../../assets/icons}/LucidePower.svg"));
      }
    '';
  };
}
