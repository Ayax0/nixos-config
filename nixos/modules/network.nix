{ pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager_strongswan
    ];
  };

  # charon-nm from networkmanager_strongswan refuses to start without this file
  environment.etc."strongswan.conf".text = "";

  services.openssh.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # bluetooth gui (blueman-manager)
  services.blueman.enable = true;
}
