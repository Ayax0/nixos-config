{ config, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    # optional: daemon.settings = { "iptables" = false; };
  };

  # (optional) Benutzer zur docker-Gruppe hinzufügen:
  users.users.ayax0.extraGroups = [ "docker" ];

  # Client-Tools in PATH:
  environment.systemPackages = with pkgs; [ docker docker-compose ];
}
