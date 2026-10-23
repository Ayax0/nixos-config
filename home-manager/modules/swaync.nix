{ ... }:

let
  c = import ../../catppuccin.nix;
in
{
  services.swaync = {
    enable = true;

    settings = {
      position = "top-right";
      monitor = "focused";
      control-center = {
        enabled = true;
        width = 400;
        height = 600;
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12pt;
        color: ${c.text};
      }

      .notification {
        background-color: alpha(${c.base}, 0.85);
        border: 2px solid alpha(${c.surface1}, 0.8);

        border-radius: 8px;
      }

      .notification-content {
        background-color: transparent;
        padding: 5px;
      }

      .notification-content:hover {
        background-color: alpha(${c.surface0}, 0.9);
      }
    '';
  };
}
