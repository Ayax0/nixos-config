{ pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager_strongswan
    ];
  };

  networking.firewall.allowedUDPPorts = [ 6454 ];

  environment.etc."strongswan.conf".text = "";

  services.openssh.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment.systemPackages = with pkgs; [
    networkmanager-l2tp
    networkmanager_strongswan
  ];
}
