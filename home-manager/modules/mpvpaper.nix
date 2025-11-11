{ pkgs, ... }:

{
  systemd.user.services.mpvpaper = {
    Service = {
      ExecStart = ''
        ${pkgs.mpvpaper}/bin/mpvpaper ALL -o "--loop --no-audio --gpu-api=vulkan --keepaspect --panscan=1.0" /etc/nixos/assets/background.mp4
      '';
      Restart = "always";
      MemoryMax = "800M";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.packages = with pkgs; [
    mpvpaper
  ];
}
