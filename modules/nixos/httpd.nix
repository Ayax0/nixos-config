{
  config,
  pkgs,
  lib,
  ...
}:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.httpd.enable = true;
  services.httpd.adminAddr = "webmaster@vtt.ch";

  services.httpd.virtualHosts."mpng.signsuite.local" = {
    documentRoot = "/var/www/mpng.signsuite.local";
    serverAliases = [ "*" ];
  };

  # hacky way to create our directory structure and index page... don't actually use this
  systemd.tmpfiles.rules = [
    "d /var/www/mpng.signsuite.local"
  ];
}
