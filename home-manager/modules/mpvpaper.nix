{ pkgs, ... }:

{
  systemd.user.services.mpvpaper = {
    Unit = {
      Description = "Animated video wallpaper using mpvpaper";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.mpvpaper}/bin/mpvpaper ALL -o "--loop --no-audio --gpu-api=vulkan --keepaspect --panscan=1.0" /etc/nixos/assets/background.mp4
      '';
      Restart = "always";
      RestartSec = "15m";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.packages = with pkgs; [ mpvpaper ];
}
