{ pkgs, ... }:

{
  systemd.user.services.polkit-agent = {
    Unit.Description = "Polkit authentication agent";
    Install.WantedBy = [ "graphical-session.target" ];
    Service.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Service.Restart = "on-failure";
  };

  home.packages = with pkgs; [ polkit_gnome ];
}