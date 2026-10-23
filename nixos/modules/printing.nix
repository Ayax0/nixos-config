{ pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
    ];
  };

  # mDNS/DNS-SD so CUPS finds network printers automatically
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # GUI to add/manage printers
  programs.system-config-printer.enable = true;
}
