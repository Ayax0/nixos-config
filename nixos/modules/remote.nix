{ config, ... }:

{
  # private network to reach this machine from anywhere; log in once with `sudo tailscale up`
  # openFirewall lets peers connect directly instead of through a DERP relay
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  # wayvnc (home-manager) is only reachable on the tailnet
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
    config.home-manager.users.ayax0.services.wayvnc.settings.port
  ];
  # wayvnc checks the account password through pam
  security.pam.services.wayvnc = { };
}
