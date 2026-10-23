{ config, ... }:

{
  # private network to reach this machine from anywhere; log in once with `sudo tailscale up`
  services.tailscale.enable = true;

  # wayvnc (home-manager) is only reachable on the tailnet
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
    config.home-manager.users.ayax0.services.wayvnc.settings.port
  ];
  # wayvnc checks the account password through pam
  security.pam.services.wayvnc = { };
}
