{ pkgs, ... }:

{
  systemd.user.services.mpvpaper = {
    Unit = {
      Description = "Animated video wallpaper using mpvpaper";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.mpvpaper}/bin/mpvpaper ALL -o "--loop --no-audio --keepaspect --panscan=1.0" /etc/nixos/assets/backround.mp4
      '';
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.packages = with pkgs; [ mpvpaper ];
}
